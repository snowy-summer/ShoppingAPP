//
//  IconType.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import Foundation

enum IconType {
    case popViewIcon
    case cameraIcon
    case searchTabBarIcon
    case settingTabBarIcon
    case deleteIcon
    case searchRecordIcon
    case editProfileIcon
    
    var iconString: String {
        switch self {
        case .popViewIcon:
            return "chevron.backward"
        case .cameraIcon:
            return "camera.fill"
        case .searchTabBarIcon:
            return "magnifyingglass"
        case .settingTabBarIcon:
            return "person"
        case .deleteIcon:
            return "xmark"
        case .searchRecordIcon:
            return "clock"
        case .editProfileIcon:
            return "chevron.forward"
        }
    }
}
