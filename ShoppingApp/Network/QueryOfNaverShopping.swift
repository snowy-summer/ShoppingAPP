//
//  QueryOfNaverShopping.swift
//  ShoppingApp
//
//  Created by 최승범 on 7/1/24.
//

import Foundation

struct QueryOfNaverShopping {
    private let query: String
    private let start: String
    private let display: String = "30"
    private let sort: String?
    
    init(query: String,
         start: String,
         sort: String) {
        
        self.query = query
        self.start = start
        self.sort = sort
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "query",
                                       value: query))
        queryItems.append(URLQueryItem(name: "start",
                                       value: query))
        queryItems.append(URLQueryItem(name: "display",
                                       value: "30"))
        queryItems.append(URLQueryItem(name: "sort",
                                       value: sort))
        
        
        return queryItems
        
    }
}
