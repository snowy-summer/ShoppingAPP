//
//  UIButton+Extension.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/17/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func capsuledButtonWithPointColor(title: String) -> UIButton.Configuration {
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.background.backgroundColor = .point
        
        var titleContainer = AttributeContainer()
        titleContainer.font = FontType.boldTitle.font
        
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        return buttonConfiguration
    }
    
}
