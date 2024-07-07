//
//  LikeListViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 7/7/24.
//

import Foundation
import RealmSwift

final class LikeListViewModel {
    
    @Published var likeList = DataBaseManager.shared.read(LikeModel.self).where {
        $0.isLike == true
    }
}
