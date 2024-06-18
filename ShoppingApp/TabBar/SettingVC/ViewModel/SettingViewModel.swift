//
//  SettingViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/18/24.
//

import Foundation

final class SettingViewModel: ObservableObject {
    
    func resetData() {
        UserData.data.resetData()
    }
    
}
