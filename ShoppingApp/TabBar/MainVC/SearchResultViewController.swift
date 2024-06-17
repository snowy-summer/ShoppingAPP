//
//  SearchResultViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import Combine
import SnapKit

final class SearchResultViewController: UIViewController {
    
    private lazy var searchResultCollectionView = UICollectionView(frame: .zero,
                                                                   collectionViewLayout: createCollectionViewLayout())
    private let searchResultHeaderView = SearchResultHeaderView()
    
    private let searchViewModel: SearchViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(keyword: String) {
        self.searchViewModel =  SearchViewModel(keyword: keyword)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configuraCollectionView()
        configureHeaderView()
        configureRefreshControl()
        binding()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        searchResultCollectionView.collectionViewLayout = createCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if searchViewModel.shoppingList.items.isEmpty { return }
        
        searchResultCollectionView.reloadData()
    }
    
}

//MARK: - Method

extension SearchResultViewController {
    
    private func binding() {
        
        searchViewModel.$shoppingList.receive(on: DispatchQueue.main)
            .sink { [weak self] shoppingList in
                guard let self = self else { return }
                
                searchResultHeaderView.updateContent(data: shoppingList.total)
                searchResultCollectionView.reloadData()
            }.store(in: &cancellables)
        
        searchViewModel.$productCount
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                if !searchViewModel.shoppingList.items.isEmpty && newValue == 1 { return }
                
                searchViewModel.getData(where: newValue)
                
            }.store(in: &cancellables)
        
        searchViewModel.$filterType
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                if searchViewModel.filterType == newValue { return }
                
                searchViewModel.resetProductCount()
                searchViewModel.getData(by: newValue)
                
            }.store(in: &cancellables)
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRefreshControl() {
        
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            searchViewModel.getData(where: 1)
            searchResultCollectionView.refreshControl?.endRefreshing()
        }
    }
}

//MARK: - CollectionView Delegate, DataSource

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return searchViewModel.shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier,
                                                            for: indexPath) as? SearchResultCollectionViewCell else {
            return SearchResultCollectionViewCell()
        }
        
        let data = searchViewModel.shoppingList.items[indexPath.row]
        
        cell.updateContent(data: data,
                           keyword: searchViewModel.keyword)
        
        cell.buttonClicked
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                searchViewModel.changeLike(productId: data.productId)
                cell.updateContent(data: data,
                                   keyword: searchViewModel.keyword)
            }.store(in: &cancellables)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(ProductWebViewController(item: searchViewModel.shoppingList.items[indexPath.row]),
                                                 animated: true)
    }
    
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            
            if searchViewModel.shoppingList.items.count - 8 == item.row &&
                searchViewModel.productCount <= searchViewModel.shoppingList.total {
                
                searchViewModel.updatepProductCount()
                
            }
        }
    }
    
}

//MARK: - Configuration

extension SearchResultViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = searchViewModel.keyword
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: IconType.popViewIcon.iconString),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        
        popViewControllerItem.tintColor = UIColor.title
        
        navigationItem.leftBarButtonItem = popViewControllerItem
    }
    
    private func configureHierarchy() {
        
        view.addSubview(searchResultCollectionView)
        view.addSubview(searchResultHeaderView)
    }
    
    private func configureHeaderView() {
        searchResultHeaderView.viewModel = searchViewModel
    }
    
    private func configuraCollectionView() {
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.prefetchDataSource = self
        
        searchResultCollectionView.collectionViewLayout = createCollectionViewLayout()
        
        searchResultCollectionView.register(SearchFilterCollectionViewCell.self,
                                            forCellWithReuseIdentifier: SearchFilterCollectionViewCell.identifier)
        searchResultCollectionView.register(SearchResultCollectionViewCell.self,
                                            forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return SearchResultSections.result.layoutSection
        }
        
    }
    
    private func configureRefreshControl() {
        searchResultCollectionView.refreshControl = UIRefreshControl()
        searchResultCollectionView.refreshControl?.addTarget(self,
                                                             action: #selector(handleRefreshControl),
                                                             for: .valueChanged)
    }
    
    private func configureLayout() {
        
        searchResultHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchResultHeaderView.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
