//
//  NicknameState.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

enum NicknameState: Equatable {
    case success
    case containNumber
    case overTheCount
    case underTheCount
    case containSpecial(String)
    
    var script: String {
        switch self {
        case .success:
            return "사용할 수 있는 닉네임이에요"
        case .containNumber:
            return "닉네임에 숫자는 포함할 수 없어요"
        case .overTheCount, .underTheCount:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .containSpecial(let value):
            return "닉네임에 \(value)는 포함할 수 없어요"
        }
    }
    
    var color: UIColor {
        switch self {
        case .success:
            return .black
        case .containNumber:
            return .point
        case .overTheCount, .underTheCount:
            return .point
        case .containSpecial:
            return .point
        }
    }
}
