//
//  SettingProfileTableCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import UIKit
import SnapKit

final class SettingProfileTableCell: UITableViewCell {
    
    private let profileImageView = ProfileView()
    private let nicknameLabel = UILabel()
    private let signUpDateLabel = UILabel()
    private let labelStackView = UIStackView()
    private let pushImageView = UIImageView()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configuration

extension SettingProfileTableCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(nicknameLabel)
        labelStackView.addArrangedSubview(signUpDateLabel)
        contentView.addSubview(pushImageView)
    }
    
    private func configureUI() {
        let data = UserData.data
        
        profileImageView.updateProfileImage(named: data.profileImageString)
        profileImageView.updateUI(by: .selected)
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        nicknameLabel.text = data.nickname
        nicknameLabel.font = FontType.boldTitle.font
        
        signUpDateLabel.text = data.signUpDate
        signUpDateLabel.font = FontType.caption.font
        signUpDateLabel.textColor = FontType.caption.color
        
        pushImageView.image = UIImage(systemName: IconType.editProfileIcon.iconString)
        pushImageView.tintColor = .icon
        
    }
    
    private func configureLayout() {
       
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.6)
        }
        
        pushImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
}

