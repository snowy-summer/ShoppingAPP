//
//  ProfileType.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit

enum ProfileType {
    case thumbnail
    case selected
    case unselected
    
    var color: CGColor {
        switch self {
        case .selected,.thumbnail:
            return UIColor.point.cgColor
        case .unselected:
            return UIColor.icon.cgColor
        }
    }
    
    var alpha: CGFloat {
        switch self {
        case .selected,.thumbnail:
            return 1
        case .unselected:
            return 0.5
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .selected,.thumbnail:
            return 3
        case .unselected:
            return 1
        }
    }
}


enum Profile: String, CaseIterable {
    case profile0 = "profile_0"
    case profile1 = "profile_1"
    case profile2 = "profile_2"
    case profile3 = "profile_3"
    case profile4 = "profile_4"
    case profile5 = "profile_5"
    case profile6 = "profile_6"
    case profile7 = "profile_7"
    case profile8 = "profile_8"
    case profile9 = "profile_9"
    case profile10 = "profile_10"
    case profile11 = "profile_11"
}
