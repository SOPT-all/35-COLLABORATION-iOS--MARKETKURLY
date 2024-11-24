//
//  HomeModels.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

struct HomeMainBannerSection: Codable, Hashable {
    let mainBannerData: [HomeMainBannerItem]?
}

struct HomeMainBannerItem: Codable, Hashable {
    let id: Int?
    let imageUrl: String?
}

struct HomeCategorySection: Codable, Hashable {
    let categoryData: [HomeCategoryItem]?
}

struct HomeCategoryItem: Codable, Hashable {
    let id: Int?
    let imageUrl: String?
    let title: String?
}

struct HomeWishListSection: Codable, Hashable {
    let mainTopData: [HomeWishListItem]?
}

struct HomeWishListItem: Codable, Hashable {
    let id: Int?
    let name: String?
    let price: Int?
    let discount: Int?
    let image: String?
}

struct HomeMidBannerSection: Codable, Hashable {
    let midBannerData: [HomeMidBannerItem]?
}

struct HomeMidBannerItem: Codable, Hashable {
    let id: Int?
    let imageUrl: String?
}
