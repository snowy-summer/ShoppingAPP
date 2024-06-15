//
//  RecordListTableViewCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation

import UIKit
import SnapKit

final class RecordListTableViewCell: UITableViewCell {
    
    private let recordIconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let deleteButton = UIButton()
    
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
//MARK: - Method

extension RecordListTableViewCell {

    func updateContent(text: String) {
        nameLabel.text = text
    }
}

//MARK: - Configuration

extension RecordListTableViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(recordIconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(deleteButton)
    }
    
    private func configureUI() {
        
        recordIconImageView.image = UIImage(systemName: IconType.searchRecordIcon.iconString)
        recordIconImageView.tintColor = .black
        
        deleteButton.titleLabel?.text = .none
        deleteButton.setImage(UIImage(systemName: IconType.deleteIcon.iconString), for: .normal)
        deleteButton.tintColor = .black
    }
    
    private func setupGestureAndButtonActions() {
        
    }
    
    private func configureLayout() {
        
        recordIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(recordIconImageView.snp.width)
            make.centerY.equalToSuperview()
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(recordIconImageView.snp.trailing).offset(20)
            make.verticalEdges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview()
        }
    }
}
