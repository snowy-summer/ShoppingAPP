//
//  ProfileView.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    
    private let profileImageView = UIImageView()
    private let cameraContainerView = IconView(icon: .cameraIcon)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        updateUI(type: .thumbnail)
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = self.frame.width / 2
        profileImageView.clipsToBounds = true
        cameraContainerView.layer.cornerRadius = cameraContainerView.layer.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(type: ProfileType) {
        profileImageView.layer.borderWidth = type.borderWidth
        profileImageView.layer.borderColor = type.color
        
        cameraContainerView.backgroundColor = .key
        
        if type != .thumbnail {
            cameraContainerView.isHidden = true
        }
    }
    
    func updateProfileImage(image: UIImage?) {
        profileImageView.image = image
    }
}

//MARK: - configuration

extension ProfileView {
    
    private func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(cameraContainerView)
        
        
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        cameraContainerView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.3)
            make.bottom.trailing.equalToSuperview().inset(profileImageView.frame.width / 4)
        }
    }
}
