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
        let configuration = URLSessionConfiguration.default
        configuration.headers.add(name: "memberId", value: "6")
        
        self.session = Session(
            configuration: configuration,
            eventMonitors: loggers
        )
    }
}
