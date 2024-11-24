//
//  TabBarPage.swift
//  MarketKurly
//
//  Created by 최지석 on 11/22/24.
//

import Foundation

enum TabBarPage: String, CaseIterable {
    
    case home
    case lounge
    case category
    case search
    case myPage

    /// Index를 받아 매칭되는 case로 반환
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .lounge
        case 2: self = .category
        case 3: self = .search
        case 4: self = .myPage
        default: return nil
        }
    }
    
    /// TabBarPage 형을 매칭되는 Int형으로 반환
    func pageIndex() -> Int {
        switch self {
        case .home: return 0
        case .lounge: return 1
        case .category: return 2
        case .search: return 3
        case .myPage: return 4
        }
    }
    
    /// TabBarPage 형을 매칭되는 한글명으로 변환
    func pageName() -> String {
        switch self {
        case .home: return "홈"
        case .lounge: return "라운지"
        case .category: return "카테고리"
        case .search: return "검색"
        case .myPage: return "마이컬리"
        }
    }
    
    /// TabBarPage 형을 매칭되는 아이콘명으로 변환
    func defaultTabItemImageName() -> String {
        switch self {
        case .home: return "icn_home_home_default"
        case .lounge: return "icn_home_lounge_default"
        case .category: return "icn_home_category_default"
        case .search: return "icn_home_search_default"
        case .myPage: return "icn_home_mykurly_default"
        }
    }
    
    func selectedTabItemImageName() -> String {
        switch self {
        case .home: return "icn_home_home_activate"
        case .lounge: return "icn_home_lounge_activate"
        case .category: return "icn_home_category_activate"
        case .search: return "icn_home_search_activate"
        case .myPage: return "icn_home_mykurly_activate"
        }
    }
}


