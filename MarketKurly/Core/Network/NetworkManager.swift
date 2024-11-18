//
//  NetworkManager.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/17/24.
//

import Foundation

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    let loggers = [NetworkLogger()] as [EventMonitor]
    var session: Session
    
    private init() {
        self.session = Session(eventMonitors: loggers)
    }
}
