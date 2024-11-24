//
//  Formatter+.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import Foundation

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal     // 천 단위로 ',' 추가
        formatter.maximumFractionDigits = 0  // 소수점 자리는 없도록 설정
        formatter.minimumFractionDigits = 0
        return formatter
    }()
}
