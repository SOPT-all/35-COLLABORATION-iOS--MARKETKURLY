//
//  HomeTarget.swift
//  MarketKurly
//
//  Created by 최지석 on 11/28/24.
//

import Foundation
import Alamofire

enum HomeTarget {
    case getHomeData
}

extension HomeTarget: TargetType {
    var baseURL: String {
        return Configuration.baseURL
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getHomeData: return .get
        }
    }
    var path: String {
        switch self {
        case .getHomeData: return "/api/v1/products/main"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getHomeData: return .none
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

