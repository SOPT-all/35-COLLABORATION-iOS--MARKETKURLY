//
//  HomeSwitchTabState.swift
//  MarketKurly
//
//  Created by 최지석 on 11/23/24.
//

import Foundation

enum HomeSwitchTabOption: Int {
    
    case marketKurly = 0
    case beautyKurly = 1
    
    init(index: Int) {
        switch index {
        case 0:
            self = .marketKurly
        case 1:
            self = .beautyKurly
        default:
            self = .marketKurly
        }
    }
}
