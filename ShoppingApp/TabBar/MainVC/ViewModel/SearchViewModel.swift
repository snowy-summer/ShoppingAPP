//
//  SearchViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    @Published private(set) var shoppingList = ShoppingList(total: 0,
                                                            start: 0,
                                                            display: 0,
                                                            items: [])
    @Published private(set) var productCount = 1
    @Published private(set) var filterType = SearchFilter.sim
    private(set) var keyword: String
    private var cancellables = Set<AnyCancellable>()
    private var networkManager = NetworkManager()
    
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
    
    func changeLike(productId: String) {
        
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
    
    
    //MARK: - 데이터 통신
    
    func fetchData(where start: Int) {
        
        let naverShopping = URLList.naverShopping(keyword, start, filterType.rawValue)
        
        networkManager.getData(what: naverShopping)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] data in
                    guard let self = self else { return }
                    if self.shoppingList.items.isEmpty {
                        self.shoppingList = data
                    } else if start != 1 {
                        self.shoppingList.items.append(contentsOf: data.items)
                    }
                }
            )
            .store(in: &cancellables)
        
    }
    
    func fetchData(by filter: SearchFilter) {
        
        let naverShopping = URLList.naverShopping(keyword,
                                                  productCount,
                                                  filter.rawValue)

        networkManager.getData(what: naverShopping)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] data in
                    guard let self = self else { return }
                    shoppingList = data
                }
            )
            .store(in: &cancellables)
        
    }
}



