//
//  ExampleApi.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/18/24.
//

import Foundation

struct ExampleApi {
    static let shared = ExampleApi()
    
    private let client = KurlyClient.shared
    
    func register(model: RequestExampleDto, completion: @escaping (Result<Bool?, NetworkError>) -> Void) {
        client.request(Bool.self, target: ExampleTarget.register(model)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

