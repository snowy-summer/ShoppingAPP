//
//  ShoppingList.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import Foundation

// MARK: - ShoppingList

struct ShoppingList: Decodable {
    
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item

struct Item: Decodable {
    
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    
}
