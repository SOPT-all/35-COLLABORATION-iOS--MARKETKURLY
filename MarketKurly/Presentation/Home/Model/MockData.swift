//
//  MockData.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import Foundation

struct MockData {
    static let homeBannerSection = HomeMainBannerSection(mainBannerData: [
        HomeMainBannerItem(id: 0, imageUrl: "img_home_banner_large_1"),
        HomeMainBannerItem(id: 1, imageUrl: "img_home_banner_large_2"),
        HomeMainBannerItem(id: 2, imageUrl: "img_home_banner_large_3"),
        HomeMainBannerItem(id: 3, imageUrl: "img_home_banner_large_4"),
        HomeMainBannerItem(id: 4, imageUrl: "img_home_banner_large_5"),
        HomeMainBannerItem(id: 5, imageUrl: "img_home_banner_large_6"),
        HomeMainBannerItem(id: 6, imageUrl: "img_home_banner_large_7"),
        HomeMainBannerItem(id: 7, imageUrl: "img_home_banner_large_8")
    ])
    
    static let categorySection = HomeCategorySection(categoryData: [
        HomeCategoryItem(id: 0, imageUrl: "icn_home_lowestprice", title: "최저가도전"),
        HomeCategoryItem(id: 1, imageUrl: "icn_home_kurlymembers", title: "컬리멤버스"),
        HomeCategoryItem(id: 2, imageUrl: "icn_home_members", title: "멤버스특가"),
        HomeCategoryItem(id: 3, imageUrl: "icn_home_kurlycurator", title: "컬리큐레이터"),
        HomeCategoryItem(id: 5, imageUrl: "icn_home_homeliving", title: "홈&리빙"),
        HomeCategoryItem(id: 6, imageUrl: "icn_home_luck", title: "행운출첵"),
        HomeCategoryItem(id: 7, imageUrl: "icn_home_fashion", title: "패션"),
        HomeCategoryItem(id: 8, imageUrl: "icn_home_todaytarot", title: "오늘의타로"),
        HomeCategoryItem(id: 9, imageUrl: "icn_home_present", title: "선물추천"),
        HomeCategoryItem(id: 10, imageUrl: "icn_home_mykurlyfarm", title: "마이컬리팜"),
        HomeCategoryItem(id: 11, imageUrl: "icn_home_livecommerce", title: "라이브쇼핑"),
        HomeCategoryItem(id: 12, imageUrl: "icn_home_showcase", title: "쇼케이스")
    ])
    
    static let wishListSection = HomeWishListSection(mainTopData: [
        HomeWishListItem(id: 0, name: "[3개 사면 33%] 비비고 통새우만두 200g", price: 4630, discount: 33, image: "img_home_card_small_shrimp"),
        HomeWishListItem(id: 1, name: "[사리원] 소불고기 전골", price: 10335, discount: 35, image: "img_home_card_small_bulgogi"),
        HomeWishListItem(id: 2, name: "아삭하고 달콤한 황금사과 1.3kg (5~7입)", price: 14900, discount: 33, image: "img_home_card_small_apple"),
        HomeWishListItem(id: 3, name: "[제각각] 당도선별 제주점보 감귤 3kg", price: 12900, discount: 18, image: "img_home_card_small_mandarin"),
        HomeWishListItem(id: 4, name: "[골라담기][네스프레소] 커피 캡슐 25종 (택2)", price: 4630, discount: 33, image: "img_home_card_small_nespresso")
    ])

}
