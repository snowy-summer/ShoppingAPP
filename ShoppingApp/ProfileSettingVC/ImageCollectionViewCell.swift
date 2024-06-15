//
//  ImageCollectionViewCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell {
    private let profileView = ProfileView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        changeType(type: .unselected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Method

extension ImageCollectionViewCell {
    
    func changeType(type: ProfileType) {
        profileView.updateUI(by: type)
    }
    
    func updateProfileImage(index: Int) {
        let imageString = Profile.allCases[index].rawValue
        
        if imageString == UserData.profileImageString { changeType(type: .selected) }
        
        profileView.updateProfileImage(named: imageString)
    }

}

//MARK: - Configuration

extension ImageCollectionViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(profileView)
    }
    
    private func configureLayout() {
        
        profileView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(contentView.snp.directionalEdges)
        }
    }
}
