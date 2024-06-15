//
//  SearchViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import Foundation
import Combine
import Alamofire

final class SearchViewModel: ObservableObject {
    
    private(set) var shoppingList = ShoppingList(total: 0, start: 0, display: 0, items: [])
    
    func getData() {
        
        let naverShopping = URLList.naverShopping("키보드", 1)
        guard let url = naverShopping.url else {
            print("잘못된 url입니다.")
            return
        }
        
        AF.request(url,
                   headers: naverShopping.headers)
        .responseDecodable(of: ShoppingList.self) { response in
            switch response.result {
                
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
