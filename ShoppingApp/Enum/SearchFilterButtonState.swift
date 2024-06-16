//
//  SearchFilterButtonState.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit

enum SearchFilterButtonState {
    case selected
    case notSelected
    
    var backgroundColor: UIColor {
        switch self {
        case .selected:
            return .placeholder
        case .notSelected:
            return .background
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .selected:
            return .background
        case .notSelected:
            return .title
        }
    }
    
    var borderColor: UIColor {
        
        return .placeholder
    }
}

enum SearchFilter: String, CaseIterable {
    case sim
    case date
    case dsc
    case asc
    
    var title: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .dsc:
            return "가격높은순"
        case .asc:
            return "가격낮은순"
        }
    }
}
