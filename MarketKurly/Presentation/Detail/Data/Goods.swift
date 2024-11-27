//
//  Goods.swift
//  MarketKurly
//
//  Created by 이세민 on 11/26/24.
//

import UIKit

struct Goods {
    let goodsImage: UIImage
    let goodsName: String
    let discountRate: String
    let price: String
    
    var packagingType: String?
    var salesUnit: String?
    var weight: String?
    var allergy: String?
    var expirationDate: String?
    var origin: String?
    var brix: Float?
    var notice: String?
    
}

extension Goods {
    static let Data: [Goods] = [
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "[제철] 청송 사과 1.5kg (4~6입)",
            discountRate: "12%",
            price: "14,900원",
            
            packagingType: "냉장 (종이상자)",
            salesUnit: "1박스",
            weight: "1.5kg 내외",
            expirationDate: "농산물로 별도의 소비기한은 없으나 가급적 빠르게 드시기 바랍니다."
            
            
        )
    ]
    
    static let relatedMockData: [Goods] = [
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "[KF365] 유명산지 고당도사과 1.5k...",
            discountRate: "16%",
            price: "19,900원"
        ),
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "감홍 사과 1.3kg (4~6입)",
            discountRate: "13%",
            price: "19,900원"
        ),
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "고랭지 햇사과 1.3kg (4~6입)",
            discountRate: "26%",
            price: "13,900원"
        ),
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "세척사과 1.4kg (7입)",
            discountRate: "25%",
            price: "14,900원"
        )
    ]
}

