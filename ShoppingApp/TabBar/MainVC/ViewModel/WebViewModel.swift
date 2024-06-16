//
//  WebViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import Foundation

final class WebViewModel: ObservableObject {
    
    private(set) var item: Item
    
    var isLicked: Bool
    
    init(item: Item) {
        self.item = item
        
        if let likeArray = UserData.data.like {
             let result = likeArray.contains(item.productId)
            self.isLicked = result
           
        } else {
            self.isLicked = false
        }
        
    }
    
    func changeLike() {
        let productId = item.productId
        
        guard let likeArray = UserData.data.like else {
            UserData.data.like = [productId]
            return
        }
       
        var setData = Set(likeArray)
        if setData.contains(productId) {
            setData.remove(productId)
        } else {
            setData.insert(productId)
        }
        
        UserData.data.like = Array(setData)
        
    }
    
}
