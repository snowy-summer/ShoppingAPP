//
//  MainViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    @Published private(set) var list = [RecordList]()
    
    func updateRecordList(text: String) {
        
        let value = RecordList(name: text,
                               date: Date())
        list.append(value)
    }
}

struct RecordList {
    let name: String
    let date: Date
}
