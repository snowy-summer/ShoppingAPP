//
//  LikeModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 7/7/24.
//

import Foundation
import RealmSwift

final class LikeModel: Object {
    
    @Persisted(primaryKey: true) var productId: String
    @Persisted var isLike: Bool
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var imageString: String
    @Persisted var lprice: String
    @Persisted var mallName: String
   
    convenience init(productId: String, isLike: Bool, title: String, link: String, imageString: String, lprice: String, mallName: String) {
        self.init()
        
        self.productId = productId
        self.isLike = isLike
        self.title = title
        self.link = link
        self.imageString = imageString
        self.lprice = lprice
        self.mallName = mallName
    }
}
