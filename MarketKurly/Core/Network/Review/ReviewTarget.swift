//
//  ReviewTarget.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import Foundation

import Alamofire

enum ReviewTarget {
    case getReviews(Int)
}

extension ReviewTarget: TargetType {
    var baseURL: String {
        return Configuration.baseURL
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getReviews: return .get
        }
    }
    var path: String {
        switch self {
        case .getReviews(let productId): return "/api/v1/products/\(productId)/reviews"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getReviews: return .none
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
