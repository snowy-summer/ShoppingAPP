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
                                                                   collectionViewLayout: createCollectionViewLayout())
    
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SearchResultSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch SearchResultSections(rawValue: indexPath.section) {
        case .filter:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchFilterCollectionViewCell.identifier,
                                                                for: indexPath) as? SearchFilterCollectionViewCell else {
                return SearchFilterCollectionViewCell()
            }
            
            let name = SearchFilter.allCases[indexPath.row].title
            cell.updateContent(name: name, type: .notSelcted)
            
            return cell
            
        case .result:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier,
                                                                for: indexPath) as? SearchResultCollectionViewCell else {
                return SearchResultCollectionViewCell()
            }
            
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
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
    
    private func configuraCollectionView() {
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.collectionViewLayout = createCollectionViewLayout()
        
        searchResultCollectionView.register(SearchFilterCollectionViewCell.self,
                                            forCellWithReuseIdentifier: SearchFilterCollectionViewCell.identifier)
        searchResultCollectionView.register(SearchResultCollectionViewCell.self,
                                            forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch SearchResultSections(rawValue: sectionIndex) {
                
            case .filter:
                return SearchResultSections.filter.layoutSection
                
            case .result:
                return SearchResultSections.result.layoutSection
                
            default:
                return SearchResultSections.result.layoutSection
                
            }
        }
    }
    
    private func configureLayout() {
        
        searchResultCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchResultCountLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
