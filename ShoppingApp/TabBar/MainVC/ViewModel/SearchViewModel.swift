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
    
    @Published private(set) var shoppingList = ShoppingList(total: 0,
                                                            start: 0,
                                                            display: 0,
                                                            items: [])
    @Published private(set) var productCount = 1
    @Published private(set) var filterType = SearchFilter.sim
    private(set) var keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
    
    func updatepProductCount() {
        productCount += 30
    }
    
    func resetProductCount() {
        productCount = 1
    }
    
    func updateFiterType(type: SearchFilter) {
        filterType = type
    }
    
    func saveLike(indexPath: IndexPath) {
        let productId = shoppingList.items[indexPath.row].productId
        
        
        guard var likeArray = UserData.data.like else {
            UserData.data.like = [productId]
            return
        }
        
        if likeArray.contains(productId) {
            let index = likeArray.firstIndex(of: productId)!
            likeArray.remove(at: index)
        } else {
            likeArray.append(productId)
        }
        
        UserData.data.like = likeArray
    }
  
    
    //MARK: - 데이터 통신
    
    func getData(where start: Int) {
        
        let naverShopping = URLList.naverShopping(keyword, start, filterType.rawValue)
        guard let url = naverShopping.url else {
            print("잘못된 url입니다.")
            return
        }
        
        AF.request(url,
                   headers: naverShopping.headers)
        .responseDecodable(of: ShoppingList.self) {[weak self] response in
            guard let self = self else { return }
            
            switch response.result {
                
            case .success(let data):
                
                if shoppingList.items.isEmpty {
                    shoppingList = data
                    return
                }
                
                if start != 1 {
                    shoppingList.items.append(contentsOf: data.items)
                    return
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getData(by filter: SearchFilter) {
      
        let naverShopping = URLList.naverShopping(keyword,
                                                  productCount,
                                                  filter.rawValue)
        guard let url = naverShopping.url else {
            print("잘못된 url입니다.")
            return
        }
        
        AF.request(url,
                   headers: naverShopping.headers)
        .responseDecodable(of: ShoppingList.self) {[weak self] response in
            guard let self = self else { return }
            
            switch response.result {
                
            case .success(let data):
                
                shoppingList = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
