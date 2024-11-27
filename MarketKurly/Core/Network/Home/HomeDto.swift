//
//  HomeDTO.swift
//  MarketKurly
//
//  Created by 최지석 on 11/28/24.
//

import Foundation

struct HomeDto: Codable, Hashable {
    let mainBottomData: [HomeRecommendListItem]?
    let mainTopProducts: [HomeWishListItem]?
    let mainMiddleProducts: [HomeRankingListItem]?
}
