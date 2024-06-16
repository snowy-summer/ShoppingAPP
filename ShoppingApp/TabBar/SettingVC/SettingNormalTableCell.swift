//
//  SettingNormalTableCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import UIKit
import SnapKit

final class SettingNormalTableCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let basketImageView = UIImageView()
    private let basketLabel = UILabel()
    
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

extension SettingNormalTableCell {
    
    func updateContent(type: SettingList) {
        titleLabel.text = type.title
        if type == .basket {
            basketImageView.isHidden = false
            basketLabel.isHidden = false
            
            if let likeCount = UserData.data.like?.count {
                basketLabel.text = "\(likeCount)" + type.accessoryDefaultText
                basketLabel.attributedText = basketLabel.text!.fontOfAttributeText(by: "\(likeCount)개")
            } else {
                basketLabel.text = "0" + type.accessoryDefaultText
                basketLabel.attributedText = basketLabel.text!.fontOfAttributeText(by: "0개")
            }
        }
    }
    
}

//MARK: - Configuration

extension SettingNormalTableCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(basketLabel)
        contentView.addSubview(basketImageView)
       
    }
    
    private func configureUI() {
        
        titleLabel.font = FontType.setting.font
        basketImageView.image = UIImage(resource: .likeSelected)
        basketImageView.isHidden = true
        basketLabel.isHidden = true
        basketLabel.font = FontType.setting.font
    }
    
    private func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.verticalEdges.equalToSuperview()
        }
        
        basketLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview()
        }
        
        basketImageView.snp.makeConstraints { make in
            make.trailing.equalTo(basketLabel.snp.leading).offset(-4)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)

        }
        
    }
    
}


