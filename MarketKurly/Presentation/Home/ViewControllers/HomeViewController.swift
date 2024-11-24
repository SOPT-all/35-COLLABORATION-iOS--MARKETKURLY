//
//  HomeViewController.swift
//  MarketKurly
//
//  Created by 최지석 on 11/22/24.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Home",
                                                  color: .black,
                                                  font: MarketKurlyFont.bodyBold16.font)
    }
    
    private let topNavigation = HomeTopNavigation()
    
    private let scrollTab = HomeScrollTab()
    
    private let contentsScrollView = UIScrollView()
    
    private let contentsStackView = UIStackView().then {
        $0.backgroundColor = .gray
    }
    
    private let topBanner = HomeMainBannerView().then {
        $0.autoScrollDuration = 5.0
        $0.isAutoScrollEnabled = true
    }
    
    
    let bannerImagesMock = ["img_home_banner_large_1",
                            "img_home_banner_large_2",
                            "img_home_banner_large_3",
                            "img_home_banner_large_4",
                            "img_home_banner_large_5",
                            "img_home_banner_large_6",
                            "img_home_banner_large_7",
                            "img_home_banner_large_8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        setUI()
        bindActions()
    }

    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubviews(
            topNavigation,
            scrollTab,
            contentsScrollView.addSubviews(
                contentsStackView.addArrangedSubviews(
                    topBanner
                )
            )
        )
        
        topNavigation.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(88)  // FIXME: top-safe-area 고려 필요
        }
        
        scrollTab.snp.makeConstraints {
            $0.top.equalTo(topNavigation.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentsScrollView.snp.makeConstraints {
            $0.top.equalTo(scrollTab.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-90)
        }
        
        contentsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        topBanner.snp.makeConstraints {
            $0.height.equalTo(278)
        }
    }
    
    
    private func bindActions() {
        scrollTab.addTarget(self, action: #selector(scrollTabValueDidChange(_:)), for: .valueChanged)
    }
    
    
                            @objc private func scrollTabValueDidChange(_ sender: HomeScrollTab) {
        print("Scroll Tab index changed: \(sender.selectedIndex)")
    }
    
    
    private func setUI() {
        // 스크롤 탭 세팅
        scrollTab.setTab(items: ["컬리추천", "베스트", "신상품", "알뜰쇼핑", "특가/혜택"],
                         animated: false)
        
        // 탑 배너 세팅
        topBanner.setImages(bannerImagesMock)
        topBanner.startAutoScroll()  // 자동 스크롤 시작
    }
}


#if DEBUG
import SwiftUI
struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        HomeViewController()
    }
}

#Preview {
    HomeViewControllerRepresentable()
}
#endif


