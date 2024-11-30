//
//  WishTarget.swift
//  MarketKurly
//
//  Created by 이세민 on 11/29/24.
//

import Foundation
import Alamofire

enum WishTarget {
    case addWish(productId: Int)
    case removeWish(productId: Int)
}

extension WishTarget: TargetType {
    var baseURL: String {
        return Configuration.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .addWish: return .post
        case .removeWish: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .addWish(let productId), .removeWish(let productId):
            return "/api/v1/likes/products/\(productId)"
        }
    }
    
    var parameters: RequestParameters {
        return .none
    }
    
    var headers: [String: String]? {
        return ["memberId": "6"]
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
