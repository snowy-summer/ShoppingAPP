//
//  NicknameChecker.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

struct NicknameChecker {
    
    static func resultOfNickname(name: String) -> NicknameState {
            
        let nicknameType = NicknameState.success
        
        if name.count < 2 {
            return .underTheCount
        } else if name.count >= 10 {
            return .overTheCount
        }
        
        let specialChar: Set = ["@", "#", "$", "%"]
        
        for value in specialChar {
            if name.contains(value) {
                return .containSpecial(value)
            }
        }
        
        if name.rangeOfCharacter(from: .decimalDigits) != nil {
            return .containNumber
        }
        
        return nicknameType
    }
    
}
