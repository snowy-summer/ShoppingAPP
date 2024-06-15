//
//  ProFileViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation
import Combine

final class ProFileViewModel: ObservableObject {
    
    @Published private(set) var imageString: String? = UserData.data.profileImageString
    @Published private(set) var nickname: String? = UserData.data.nickname
    
    func updateImageString(_ newValue: String?) {
        imageString = newValue
        UserData.data.profileImageString = newValue
    }
    
    func updateNickname(_ newValue: String) {
        nickname = newValue
        UserData.data.nickname = newValue
    }
}
