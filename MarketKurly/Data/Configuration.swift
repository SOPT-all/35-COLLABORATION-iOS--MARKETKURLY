//
//  Const.swift
//  MarketKurly
//
//  Created by 최지석 on 11/29/24.
//

import Foundation

public enum Configuration {
    static let baseURL: String = {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("No Configuration Found")
        }
        return url
    }()
}
