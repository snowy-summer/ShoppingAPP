//
//  NicknameChecker.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

struct NicknameChecker {
    
    static func resultOfNickname(name: String) -> NicknameStatus {
        
        var nicknameType = NicknameStatus.sucess
        
        if name.count >= 2 && name.count < 10 {
        
            if name.contains("@") ||
                name.contains("#") ||
                name.contains("$") ||
                name.contains("%") {
                
                nicknameType = .containSpecial
            }
            
            if name.rangeOfCharacter(from: .decimalDigits) != nil {
                nicknameType = .containNumber
            }
            
        } else {
            
            nicknameType = .overTheCount
        }
        
        return nicknameType
    }
    
}
