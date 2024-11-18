//
//  ExampleTarget.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/18/24.
//

import Foundation

import Alamofire

enum ExampleTarget {
    case register(RequestExampleDto)
}

extension ExampleTarget: TargetType {
    var baseURL: String {
        return "http://123456"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .register: return .post
        }
    }
    var path: String {
        switch self {
        case .register: return "/user"
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .register(let request): return .body(request)
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
