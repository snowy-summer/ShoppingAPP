//
//  SelectProfileViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit
import Combine
import SnapKit

final class SelectProfileViewController: UIViewController {
    
    private let profileThumbnailView = ProfileView()
    private lazy var selectCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: configureCollectionViewLayout())
    
    private let profileViewModel = ProFileViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureNavigationBar()
        configureHierarchy()
        configureCollectionView()
        configureLayout()
        profileThumbnailView.updateProfileImage(named: UserData.data.profileImageString)
        binding()
    }
    
}

//MARK: - Method

extension SelectProfileViewController {
    
    private func binding() {
        profileViewModel.$imageString
            .sink {[weak self] newValue in
                guard let self = self else { return }
                
                profileThumbnailView.updateProfileImage(named: newValue)
                selectCollectionView.reloadData()
            }.store(in: &cancellables)
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - CollectionViewDelegate, datasource

extension SelectProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return Profile.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                            for: indexPath) as? ImageCollectionViewCell else {
            return ImageCollectionViewCell()
        }
        
        cell.changeType(type: .unselected)
        cell.updateProfileImage(index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let imageString = Profile.allCases[indexPath.row].rawValue
        profileViewModel.updateImageString(imageString)
        
    }
    
}

//MARK: - Configuration

extension SelectProfileViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = "PROFILE SETTING"
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: IconType.popViewIcon.iconString),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        popViewControllerItem.tintColor = .title
        
        navigationItem.leftBarButtonItem = popViewControllerItem
    }
    
    private func configureHierarchy() {
        
        view.addSubview(profileThumbnailView)
        view.addSubview(selectCollectionView)

    }
    
    private func configureCollectionView() {
        
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
        
        selectCollectionView.register(ImageCollectionViewCell.self,
                                      forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20,
                                           left: 20,
                                           bottom: 20,
                                           right: 20)
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let width = view.bounds.width - 24 - 40
        layout.itemSize = CGSize(width: width / 4,
                                 height: width / 4)
        
        return layout
    }
    
    private func configureLayout() {
        
        profileThumbnailView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        selectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileThumbnailView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
}
