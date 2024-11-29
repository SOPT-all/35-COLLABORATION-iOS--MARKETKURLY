//
//  ResponseData.swift
//  MarkestKurly
//
//  Created by 최지석 on 11/28/24.
//

struct ResponseData<T: Decodable>: Decodable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: T?
}
