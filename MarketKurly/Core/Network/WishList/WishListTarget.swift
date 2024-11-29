//
//  WishListTarget.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import Foundation

import Alamofire

enum WishListTarget {
    case getWishList(Int)
}

extension WishListTarget: TargetType {
    var baseURL: String {
        return Configuration.baseURL
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getWishList: return .get
        }
    }
    var path: String {
        switch self {
        case .getWishList: return "/api/v1/likes"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getWishList: return .none
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var headers: [String: String]? {
        switch self {
        case .getWishList(let memberId):
            return ["Content-Type": "application/json", "memberId" : "\(memberId)"]
        }
    }
}
