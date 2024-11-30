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
    
    func addWish(productId: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        client.request(target: WishTarget.addWish(productId: productId)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func removeWish(productId: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        client.request(target: WishTarget.removeWish(productId: productId)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
