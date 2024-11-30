//
//  DetailDTO.swift
//  MarketKurly
//
//  Created by 이세민 on 11/29/24.
//

import Foundation

struct DetailDto: Codable, Hashable {
    let name: String
    let price: Int
    let discount: Int
    let discountedPrice: Int
    let image: String
    let membersDiscount: Int
    let membersDiscountedPrice: Int
    let deliveryType: String
    let seller: String
    let origin: String
    let packagingType: String
    let sellingUnit: String
    let weight: String
    let expiration: String
    let brix: Float?
    let notification: String
    let category: String
    let allergy: String
    let isInterest: Bool
}
