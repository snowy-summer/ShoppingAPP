//
//  FontType.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

enum FontType {
    case onboardingTitle
    case normaltitle
    case boldTitle
    case body
    case setting
    case boldSetting
    case caption

    var font: UIFont {
        switch self {
        case .onboardingTitle:
            return UIFont.systemFont(ofSize: 36, weight: .black)
        case .normaltitle:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case .boldTitle:
            return UIFont.systemFont(ofSize: 16, weight: .bold)
        case .body:
            return UIFont.systemFont(ofSize: 15, weight: .medium)
        case .setting:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .boldSetting:
            return UIFont.systemFont(ofSize: 14, weight: .bold)
        case .caption:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
      
        }
    }
    
    var color: UIColor {
        switch self {
        case .onboardingTitle:
            return .point
        case .caption:
            return .subtitle
        default :
            return .title
        }
    }
}
