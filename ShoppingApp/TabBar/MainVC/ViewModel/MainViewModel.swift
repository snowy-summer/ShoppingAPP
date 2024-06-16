//
//  MainViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    @Published private(set) var list = UserData.data.searchRecordList
    
    func updateRecordList(text: String) {
        
        var oldList: [RecordList]
        
        if list == nil {
            oldList = []
        } else {
            oldList = list!
        }
        
        let value = RecordList(name: text,
                               date: Date())
        oldList.append(value)
        list = oldList
        UserData.data.searchRecordList = oldList
    }
    
    func deleteRecordList(at index: Int) {
        
        guard var oldList = list else { return }
        
        oldList.remove(at: index)
        list = oldList
        UserData.data.searchRecordList = oldList
    }
    
    func deleteListAll() {
        
        list = []
        UserData.data.deleteSearchRecordList()
    }
}
