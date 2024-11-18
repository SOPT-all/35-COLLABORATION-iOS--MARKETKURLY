//
//  NetworkRequestable.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/17/24.
//

import Foundation

protocol NetworkRequestable {
    func request<T: Decodable>(
        _ model: T.Type,
        target: TargetType,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
    
    func request(
        target: TargetType,
        completion: @escaping (Result<Bool, NetworkError>) -> Void
    )
}

