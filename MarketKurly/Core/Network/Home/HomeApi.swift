//
//  HomeApi.swift
//  MarketKurly
//
//  Created by 최지석 on 11/28/24.
//

import Foundation

struct HomeApi {
    static let shared = HomeApi()
    
    private let client = KurlyClient.shared
    
    func getHomeData(completion: @escaping (Result<HomeDto, NetworkError>) -> Void) {
        client.request(HomeDto.self, target: HomeTarget.getHomeData) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

