//
//  NetworkError.swift
//  ShoppingApp
//
//  Created by 최승범 on 7/2/24.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    
    case decoding
    case invalidResponse
    
    var description: String {
        switch self {
        case .decoding:
            return "디코딩 에러"
        case .invalidResponse:
            return "응답 없음"
        }
    }
}
