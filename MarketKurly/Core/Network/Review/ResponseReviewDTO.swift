//
//  ResponseReviewDto.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import Foundation

struct ResponseReviewDTO : Decodable {
    let reviews: [Review]
}

struct Review: Decodable {
    let userName: String
    let content: String
    let score: Double
    let isAdd: Bool
    let image1: String?
    let image2: String?
    let image3: String?
    let createdAt: String
}
