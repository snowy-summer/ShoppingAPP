//
//  SettingList.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import Foundation

enum SettingList: Int, CaseIterable {
    
    enum Section: Int, CaseIterable {
        case profile
        case list
    }
    
    case basket
    case FAQ
    case personalAsk
    case alertSetting
    case withdraw
    
    var title: String {
        switch self {
        case .basket:
            return "나의 장바구니 목록"
        case .FAQ:
            return "자주 묻는 질문"
        case .personalAsk:
            return "1:1 문의"
        case .alertSetting:
            return "알림 설정"
        case .withdraw:
            return "탈퇴하기"
        }
    }
    
    var accessoryDefaultText: String {
        switch self {
        case .basket:
            return "개의 상품"
        default:
            return ""
        }
    }

}
