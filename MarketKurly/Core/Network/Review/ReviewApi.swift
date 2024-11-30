//
//  ReviewApi.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import Foundation

struct ReviewApi {
    static let shared = ReviewApi()
    
    private let client = KurlyClient.shared
    
    func getReviews(productId: Int, completion: @escaping (Result<ResponseReviewDTO?, NetworkError>) -> Void) {
        client.request(ResponseReviewDTO.self, target: ReviewTarget.getReviews(productId)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
