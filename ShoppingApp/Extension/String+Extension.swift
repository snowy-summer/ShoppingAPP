//
//  String+Extension.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import Foundation

extension String {
    
    var removeHtmlTag: String {
        replacingOccurrences(of: "</?\\w+>", with: "", options: .regularExpression)
    }
}
