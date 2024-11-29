//
//  DetailTarget.swift
//  MarketKurly
//
//  Created by 이세민 on 11/29/24.
//

import Foundation
import Alamofire

enum DetailTarget {
    case getDetailData(productId: Int)
}

extension DetailTarget: TargetType {
    var baseURL: String {
        return "http://211.188.50.209:8080"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getDetailData: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDetailData(let productId): return "/api/v1/products/\(productId)"
        }
    }
    
    var parameters: RequestParameters {
        return .none
    }
    
    var headers: HTTPHeaders? {
        return ["memberId": "6"]
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
