//
//  NicknameStatus.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

enum NicknameStatus {
    case sucess
    case containNumber
    case overTheCount
    case containSpecial
    
    var script: String {
        switch self {
        case .sucess:
            return "사용할 수 있는 닉네임이에요"
        case .containNumber:
            return "닉네임에 숫자는 포함할 수 없어요"
        case .overTheCount:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .containSpecial:
            return "닉네임에 @,#,$,%는 포함할 수 없어요"
        }
    }
    
    var color: UIColor {
        switch self {
        case .sucess:
            return .black
        case .containNumber:
            return .key
        case .overTheCount:
            return .key
        case .containSpecial:
            return .key
        }
    }
}
