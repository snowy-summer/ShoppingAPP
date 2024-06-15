//
//  SearchResultViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultViewController: UIViewController {
    
    private lazy var searchResultCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: UICollectionViewLayout())
    
    private let searchViewModel = SearchViewModel()
    
    private let searchResultCountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureHierarchy()
        configureUI()
        configureLayout()
        configuraCollectionView()
        binding()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        searchResultCollectionView.collectionViewLayout = createCollectionViewLayout()
    }
    
}

//MARK: - Method

extension SearchResultViewController {
    
    private func binding() {
        
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - CollectionView Delegate, DataSource

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectioViewCell.identifier,
                                                            for: indexPath) as? SearchResultCollectioViewCell else {
            return SearchResultCollectioViewCell()
        }
        cell.backgroundColor = .point
        
        return cell
    }
    
}



//MARK: - Configuration

extension SearchResultViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = "결과"
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: IconType.popViewIcon.iconString),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        
        popViewControllerItem.tintColor = UIColor.title
        
        navigationItem.leftBarButtonItem = popViewControllerItem
    }
    
    private func configureHierarchy() {
     
        view.addSubview(searchResultCollectionView)
        view.addSubview(searchResultCountLabel)
    }
    
    private func configureUI() {
        searchResultCountLabel.text = "aaaa"
        searchResultCountLabel.textColor = .point
    }
    
    private func configureGestureAndButtonActions() {
        
    }
    
    private func configuraCollectionView() {
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.collectionViewLayout = createCollectionViewLayout()
        searchResultCollectionView.backgroundColor = .gray
        
        searchResultCollectionView.register(SearchResultCollectioViewCell.self,
                                            forCellWithReuseIdentifier: SearchResultCollectioViewCell.identifier)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        
        var layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 20,
                                           bottom: 0,
                                           right: 20)
        let width = (view.frame.width - 50) / 2
        let height = (searchResultCollectionView.frame.height - 10) / 2
     
        layout.itemSize = CGSize(width: width,
                                 height: height)
        
        return layout
    }
    
    private func configureLayout() {
        
        searchResultCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchResultCountLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
