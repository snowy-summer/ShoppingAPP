//
//  SearchFilterCollectionViewCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import SnapKit

final class SearchFilterCollectionViewCell: UICollectionViewCell {
    
    private let fileterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fileterButton.layer.cornerRadius = bounds.height / 2
        fileterButton.layer.masksToBounds = true
    }
    
}

//MARK: - Method

extension SearchFilterCollectionViewCell {
    
    func updateContent(name: String,
                       type: SearchFilterButtonState) {
      
        var buttonConfiguration = UIButton.Configuration.filled()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = FontType.normaltitle.font
        titleContainer.foregroundColor = type.titleColor
        
        buttonConfiguration.attributedTitle = AttributedString(name, attributes: titleContainer)
        
        fileterButton.configuration = buttonConfiguration
        fileterButton.tintColor = type.backgroundColor
        fileterButton.layer.borderColor = type.borderColor.cgColor
    }
    
}

//MARK: - Configuration

extension SearchFilterCollectionViewCell {

    private func configureHierarchy() {
        
        contentView.addSubview(fileterButton)
    }
    
    private func configureUI() {
        
        fileterButton.layer.borderWidth = 1
        fileterButton.layer.borderColor = SearchFilterButtonState.notSelected.borderColor.cgColor
    }
 
    private func configureLayout() {
        
        fileterButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    
    }
}

