//
//  CapsuledButton.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit

final class CapsuledButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        configuration = configure(title: title)
        tintColor = .point
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String) -> UIButton.Configuration {
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.cornerStyle = .capsule
        
        var titleContainer = AttributeContainer()
        titleContainer.font = FontType.boldTitle.font
        
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        return buttonConfiguration
    }
}
