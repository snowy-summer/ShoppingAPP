//
//  ProfileSettingViewControllerType.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import Foundation

enum ProfileSettingViewControllerType {
    case create
    case setting
    
    var navigationTitle: String {
        switch self {
        case .create:
            return "PROFILE SETTING"
            
        case .setting:
            return "EDIT PROFILE"
        }
    }
}
