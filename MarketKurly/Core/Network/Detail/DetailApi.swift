//
//  DetailApi.swift
//  MarketKurly
//
//  Created by 이세민 on 11/29/24.
//

import Foundation

struct DetailApi {
    static let shared = DetailApi()
    
    private let client = KurlyClient.shared
    
    func getDetailData(productId: Int, completion: @escaping (Result<DetailDto?, NetworkError>) -> Void) {
        client.request(DetailDto.self, target: DetailTarget.getDetailData(productId: productId)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
