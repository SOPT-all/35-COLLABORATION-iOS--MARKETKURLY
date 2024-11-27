//
//  Goods.swift
//  MarketKurly
//
//  Created by 이세민 on 11/26/24.
//

import UIKit

struct Goods {
    // PriceInfo, RelatedGoods, GoodsInfo 공통
    let goodsImage: UIImage
    let goodsName: String
    let discountRate: Int // 할인율
    let discountPrice: Int // 할인가
    
    // PriceInfo
    var deliveryType: String?
    var origin: String?
    var costPrice: Int? // 원가
    var membersRate: Int? // 멤버스 할인율
    var membersPrice: Int? // 멤버스 판매가
    
    // GoodsInfo
    var packagingType: String?
    var salesUnit: String?
    var weight: String?
    var allergy: String?
    var expirationDate: String?
    var brix: Float?
    var notice: String?
}

extension Goods {
    static let infoMockData: [Goods] = [
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "[제철] 청송 사과 1.5kg (4~6입)",
            discountRate: 12,
            discountPrice: 14900,
            deliveryType: "샛별배송",
            origin: "국산",
            costPrice: 16900,
            membersRate: 28,
            membersPrice: 12120,
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
            discountRate: 16,
            discountPrice: 19900
        ),
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "감홍 사과 1.3kg (4~6입)",
            discountRate: 13,
            discountPrice: 19900
        ),
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "고랭지 햇사과 1.3kg (4~6입)",
            discountRate: 26,
            discountPrice: 13900
        ),
        Goods(
            goodsImage: UIImage(systemName: "applelogo")!.withTintColor(.red, renderingMode: .alwaysOriginal),
            goodsName: "세척사과 1.4kg (7입)",
            discountRate: 25,
            discountPrice: 14900
        )
    ]
}
