//
//  NetworkManager.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/18/24.
//

import Foundation
import Combine
import Alamofire

struct NetworkManager {
    func getData(what url: URLList) -> AnyPublisher<ShoppingList, AFError> {
        
        return AF.request(url.url!,
                          headers: url.headers)
        .publishDecodable(type: ShoppingList.self)
        .value()
        .eraseToAnyPublisher()
    }
}
