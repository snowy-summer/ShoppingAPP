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
    func getData<T: Decodable>(what url: URLList,
                               _ object: T.Type) -> AnyPublisher<Decodable, Error> {
        
        return Future { promise in
            AF.request(url.url!,
                       headers: url.headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    promise(.success(data))
                case .failure(_ ):
                    if let data = response.data {
                        do {
                            let failResult = try JSONDecoder().decode(ErrorDTO.self,
                                                                      from: data)
                            promise(.success(failResult))
                        } catch {
                            promise(.failure(NetworkError.decoding))
                        }
                    } else {
                        promise(.failure(NetworkError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
