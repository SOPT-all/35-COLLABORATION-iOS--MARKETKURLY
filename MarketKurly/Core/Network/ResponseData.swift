//
//  ResponseData.swift
//  MarketKurly
//
//  Created by 최지석 on 11/28/24.
//

struct ResponseData<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let data: T
}
