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
    private let cameraButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        updateUI(by: .thumbnail)
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = self.frame.width / 2
        profileImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(by type: ProfileType) {
        profileImageView.layer.borderWidth = type.borderWidth
        profileImageView.layer.borderColor = type.color
        profileImageView.alpha = type.alpha
        
        configureButton()
        
        if type != .thumbnail {
            cameraButton.isHidden = true
        }
    }
    
    func updateProfileImage(named: String?) {
        
        guard let imageString = named else { return }
        
        profileImageView.image = UIImage(named: imageString)
    }
}

//MARK: - configuration

extension ProfileView {
    
    private func configureHierarchy() {
        
        addSubview(profileImageView)
        addSubview(cameraButton)
    }
    
    private func configureButton() {
        
        cameraButton.tintColor = .point
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: IconType.cameraIcon.iconString)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16)
        configuration.cornerStyle = .capsule
        
        cameraButton.configuration = configuration
    }
    
    private func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.3)
            make.bottom.trailing.equalToSuperview().inset(profileImageView.frame.width / 4)
        }
    }
}
