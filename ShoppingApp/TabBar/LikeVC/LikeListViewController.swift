//
//  LikeListViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 7/7/24.
//

import UIKit
import Combine
import SnapKit
import RealmSwift

final class LikeListViewController: UIViewController {
    
    private lazy var likeListCollectionView = UICollectionView(frame: .zero,
                                                          collectionViewLayout: createCollectionViewLayout())
    private let likeViewModel = LikeListViewModel()
    private var anyCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureHierarchy()
        configureCollectionView()
        configureLayout()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        likeListCollectionView.reloadData()
    }
    
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return SearchResultSections.result.layoutSection
        }
        
    }
}

//MARK: - collectionView delegate, datasource
extension LikeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return likeViewModel.likeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier,
                                                            for: indexPath) as? SearchResultCollectionViewCell else {
            return SearchResultCollectionViewCell()
        }
        
        let data = likeViewModel.likeList[indexPath.row]
        
        cell.delegate = self
        cell.updateLikeContent(data: data)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let data = likeViewModel.likeList[indexPath.row]
        navigationController?.pushViewController(ProductWebViewController(data: data),
                                                 animated: true)
    }
    
    
}

//MARK: - SearchResultCollectionViewCellDelegate
extension LikeListViewController: SearchResultCollectionViewCellDelegate {
    
    func likeButtonClicked(indexPath: IndexPath) {
        
        let data = likeViewModel.likeList[indexPath.row]
        
        let likeModel = DataBaseManager.shared.read(LikeModel.self).where {
            $0.productId == data.productId
        }
        
        DataBaseManager.shared.update(likeModel.first!) { likeModel in
            likeModel.isLike.toggle()
        }
        
        likeListCollectionView.reloadData()
    }
    
}

//MARK: - Configuration

extension LikeListViewController {
    
    private func configureHierarchy() {
        
        view.addSubview(likeListCollectionView)
    }
    
    private func configureCollectionView() {
        
        likeListCollectionView.delegate = self
        likeListCollectionView.dataSource = self
        likeListCollectionView.register(SearchResultCollectionViewCell.self,
                                        forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
    }
    
    private func configureLayout() {
        
        likeListCollectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}



