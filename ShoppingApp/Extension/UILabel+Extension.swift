//
//  UILabel+Extension.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit

extension UILabel {
    
    func configure(by fotType: FontType) {
        font = fotType.font
        textColor = fotType.color
    }
}
