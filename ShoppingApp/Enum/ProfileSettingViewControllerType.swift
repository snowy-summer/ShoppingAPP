//
//  ProfileSettingViewControllerType.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import Foundation

enum ProfileSettingViewControllerType {
    case first
    case setting
    
    var navigationTitle: String {
        switch self {
        case .first:
            return "PROFILE SETTING"
            
        case .setting:
            return "EDIT PROFILE"
        }
    }
}
