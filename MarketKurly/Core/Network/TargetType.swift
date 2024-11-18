//
//  TargetType.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/17/24.
//

import Foundation

import Alamofire

public protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParameters { get }
}

public extension TargetType {
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

extension TargetType {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        if let headers = headers {
            urlRequest.headers = HTTPHeaders(headers)
        }
        
        switch parameters {
        case .none:
            break
            
        case .query(let request):
            if let dictionary = request?.toDictionary() {
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: dictionary)
            }
            
        case .body(let request):
            if let dictionary = request?.toDictionary() {
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: dictionary)
            }
        }
        
        return urlRequest
    }
}
