//
//  WishApi.swift
//  MarketKurly
//
//  Created by 이세민 on 11/29/24.
//

import Foundation

struct WishApi {
    static let shared = WishApi()
    
    private let client = KurlyClient.shared
    
    func addWish(productId: Int, completion: @escaping (Result<WishResponseDto, NetworkError>) -> Void) {
        client.request(WishResponseDto.self, target: WishTarget.addWish(productId: productId)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func removeWish(productId: Int, completion: @escaping (Result<WishResponseDto, NetworkError>) -> Void) {
        client.request(WishResponseDto.self, target: WishTarget.removeWish(productId: productId)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
