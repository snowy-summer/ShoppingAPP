//
//  IconView.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit

final class IconView: UIView {
    
    private let iconImageView = UIImageView()
    
    init(icon: IconType) {
        super.init(frame: .zero)
        
        configureHierarchy()
        configureUI(icon: icon)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        
        addSubview(iconImageView)
    }
    
    private func configureUI(icon: IconType) {
        
        let image = UIImage(systemName: icon.iconString)
        iconImageView.image = image
        iconImageView.tintColor = .white
        
    }
    
    private func configureLayout() {
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.height.equalTo(iconImageView.snp.width).multipliedBy(0.8)
        }
    }
}
