//
//  WishListApi.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import Foundation

struct WishListApi {
    static let shared = WishListApi()
    
    private let client = KurlyClient.shared
    
    func getWishList(memberId: Int, completion: @escaping (Result<ResponseWishListDTO, NetworkError>) -> Void) {
        client.request(ResponseWishListDTO.self, target: WishListTarget.getWishList(memberId)) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
