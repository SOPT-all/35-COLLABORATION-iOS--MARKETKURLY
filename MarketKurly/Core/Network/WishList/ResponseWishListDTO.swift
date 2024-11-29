//
//  ResponseWishListDto.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import Foundation

struct ResponseWishListDTO : Decodable {
    let products: [Product]
}

struct Product : Decodable {
    let name: String
    let image: String
    let price: Int
    let discount: Int
    let categoryScope: String
}
