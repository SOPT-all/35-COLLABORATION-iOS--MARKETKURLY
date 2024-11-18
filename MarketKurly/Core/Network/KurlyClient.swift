//
//  KurlyClient.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/17/24.
//

import Foundation

import Alamofire

final class KurlyClient: NetworkRequestable {
    
    static let shared = KurlyClient()
    
    private init() {}
    
    func request<T: Decodable>(
        _ model: T.Type,
        target: any TargetType,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        NetworkManager
            .shared
            .session
            .request(target)
            .validate()
            .responseData { response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(.parsingError))
                    }
                    
                case .failure:
                    let error = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(error))
                }
            }
    }
    
    func request(target: any TargetType, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        NetworkManager
            .shared
            .session
            .request(target)
            .validate()
            .responseData { response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data else {
                    completion(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                    completion(.success(true))
                    
                case .failure:
                    let error = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(error))
                }
            }
    }
    
    private func handleStatusCode(
        _ statusCode: Int,
        data: Data
    ) -> NetworkError {
        let errorCode = decodeError(data: data)
        switch (statusCode, errorCode) {
        case (400, "00"):
            return .invalidRequest
        case (400, "01"):
            return .expressionError
        case (400, "02"):
            return .invalidLoginError
        case (404, ""):
            return .invalidURL
        case (409, "00"):
            return .duplicateError
        case (500, ""):
            return .serverError
        default:
            return .unknownError
        }
    }
    
    private func decodeError(data: Data) -> String {
        guard let errorResponse = try? JSONDecoder().decode(
            ErrorResponse.self,
            from: data
        ) else { return "" }
        return errorResponse.code
    }
}
