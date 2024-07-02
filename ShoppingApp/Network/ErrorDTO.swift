//
//  ErrorDTO.swift
//  ShoppingApp
//
//  Created by 최승범 on 7/2/24.
//

import Foundation
struct ErrorDTO: Decodable {
    let errorMessage: String
    let errorCode: String
}
