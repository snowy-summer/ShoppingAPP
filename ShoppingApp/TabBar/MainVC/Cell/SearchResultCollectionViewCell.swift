//
//  SearchResultCollectionViewCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import Combine
import SnapKit
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    
    private let thumbnailImageView = UIImageView()
    private let likeButton = UIButton()
    private let storeNameLabel = UILabel()
    private let titleLabel = UILabel()
    private let costLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    private(set) var buttonClicked = PassthroughSubject<Void, Never>()
    
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

extension SearchResultCollectionViewCell {
    
    func updateContent(data: Item, keyword: String) {
        
        thumbnailImageView.kf.setImage( with: URL(string: data.image),
                                        placeholder: nil,
                                        options: nil,
                                        progressBlock: nil) 
        { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.activityIndicator.stopAnimating()
                
            case .failure(let error):
                print("Error loading image: \(error)")
                self.activityIndicator.stopAnimating()
            }
        }
        
        storeNameLabel.text = data.mallName
        titleLabel.text = data.title.removeHtmlTag
        titleLabel.attributedText = data.title.removeHtmlTag.highlightOfAttributeText(by: keyword)
        
        if let price = Int(data.lprice)?.formatted() {
            costLabel.text = price + "원"
        }
        
        if let likeArray = UserData.data.like {
            
            let isLiked = likeArray.contains(data.productId)
            configureLikeButton(isLiked: isLiked)
        }
    }
    
    @objc private func likeButtonClicked() {
        buttonClicked.send()
    }
}

//MARK: - Configuration

extension SearchResultCollectionViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(storeNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(activityIndicator)
        
    }
    
    private func configureUI() {
        
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.layer.cornerCurve = .continuous
        thumbnailImageView.clipsToBounds = true
        
        configureLikeButton(isLiked: false)
        
        storeNameLabel.configure(by: .caption)
        
        titleLabel.configure(by: .normaltitle)
        titleLabel.numberOfLines = 2
        
        costLabel.configure(by: .boldTitle)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        
    }
    
    private func configureGestureAndButtonActions() {
        
        likeButton.addTarget(self,
                             action: #selector(likeButtonClicked),
                             for: .touchUpInside)
        
    }
    
    private func configureLikeButton(isLiked: Bool) {
        
        var configuration = UIButton.Configuration.filled()
        
        configuration.image = isLiked ? UIImage(resource: .likeSelected) : UIImage(resource: .likeUnselected)
        configuration.background.backgroundColor = isLiked ?  UIColor.background : UIColor.subtitle.withAlphaComponent(0.2)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14)
        configuration.cornerStyle = .medium
        
        likeButton.configuration = configuration
    }
    
    private func configureLayout() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(thumbnailImageView.snp.bottom).inset(8)
            make.trailing.equalTo(thumbnailImageView.snp.trailing).inset(8)
            make.width.equalTo(thumbnailImageView.snp.width).multipliedBy(0.2)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(0.2)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(4)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(4)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(thumbnailImageView.snp.center)
            make.size.equalTo(50)
        }
    }
}
