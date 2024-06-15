//
//  SearchFilterButtonType.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit

enum SearchFilterButtonType {
    case selected
    case notSelcted
    
    var backgroundColor: UIColor {
        switch self {
        case .selected:
            return .placeholder
        case .notSelcted:
            return .background
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .selected:
            return .background
        case .notSelcted:
            return .title
        }
    }
    
    var borderColor: UIColor {
        
        return .placeholder
    }
}
