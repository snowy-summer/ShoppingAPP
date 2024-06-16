//
//  String+Extension.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import UIKit

extension String {
    
    var removeHtmlTag: String {
        replacingOccurrences(of: "</?\\w+>", with: "", options: .regularExpression)
    }
    
    func fontOfAttributeText(by text: String?) -> NSMutableAttributedString? {
        
        guard let text = text else { return nil }
        
        let attributedString = NSMutableAttributedString(string: self)
        
        if let range = self.range(of: text) {
            let nsRange = NSRange(range, in: self)
            attributedString.addAttribute(.font,
                                          value: FontType.boldSetting.font,
                                          range: nsRange)
        }
        
        return attributedString
    }
    
    func highlightOfAttributeText(by text: String?) -> NSMutableAttributedString? {
        
        guard let text = text else { return nil }
        
        let attributedString = NSMutableAttributedString(string: self)
        
        if let range = self.range(of: text) {
            let nsRange = NSRange(range, in: self)
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.point,
                                          range: nsRange)
        }
        
        return attributedString
    }
}
