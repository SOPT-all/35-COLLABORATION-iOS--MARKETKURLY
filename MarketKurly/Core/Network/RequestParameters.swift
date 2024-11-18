//
//  RequestParameters.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/17/24.
//

import Foundation

public enum RequestParameters {
    case none
    case query(_ Parameters: Encodable?)
    case body(_ parameters: Encodable?)
}

