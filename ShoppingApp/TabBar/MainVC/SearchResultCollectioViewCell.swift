//
//  SearchResultCollectioViewCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import SnapKit

final class SearchResultCollectioViewCell: UICollectionViewCell {
    
    private let thumbnailImageView = UIImageView()
    private let basketIconImageView = UIImageView()
    private let storeNameLabel = UILabel()
    private let titleLabel = UILabel()
    private let costLabel = UILabel()
    
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

extension SearchResultCollectioViewCell {
    
    func updateContent(data: Int) {
        
    }
    
}

//MARK: - Configuration

extension SearchResultCollectioViewCell {

    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(basketIconImageView)
        contentView.addSubview(storeNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(costLabel)
        
    }
    
    private func configureUI() {
        
    }
    
    private func configureGestureAndButtonActions() {
        
    }
    
    private func configureLayout() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        basketIconImageView.snp.makeConstraints { make in
            make.bottom.equalTo(thumbnailImageView.snp.bottom).inset(8)
            make.trailing.equalTo(thumbnailImageView.snp.trailing).inset(8)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview().inset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview().inset(4)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(4)
        }
    }
}
