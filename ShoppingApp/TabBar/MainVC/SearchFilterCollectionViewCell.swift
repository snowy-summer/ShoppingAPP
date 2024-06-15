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
        configureGestureAndButtonActions()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Method

extension SearchFilterCollectionViewCell {
    
    func updateContent(name: String,
                       type: SearchFilterButtonType) {
        
        fileterButton.setTitle(name,
                               for: .normal)
        fileterButton.setTitleColor(type.titleColor,
                                    for: .normal)
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
        
        var configuration = UIButton.Configuration.filled()
        
        configuration.cornerStyle = .capsule
        fileterButton.configuration = configuration
        fileterButton.tintColor = .background
        fileterButton.layer.borderWidth = 1
        fileterButton.layer.borderColor = SearchFilterButtonType.notSelcted.borderColor.cgColor
    }
    
    private func configureGestureAndButtonActions() {
        
    }
    
    private func configureLayout() {
        
        fileterButton.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    
    }
}

