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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        bindActions()
    }

    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubviews(
            topNavigation,
            scrollTab
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
        
        scrollTab.setTab(items: ["컬리추천", "베스트", "신상품", "알뜰쇼핑", "특가/혜택"], animated: false)
    }
    
    
    private func bindActions() {
        scrollTab.addTarget(self, action: #selector(scrollTabValueDidChange(_:)), for: .valueChanged)
    }
    
    
                            @objc private func scrollTabValueDidChange(_ sender: HomeScrollTab) {
        print("Scroll Tab index changed: \(sender.selectedIndex)")
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


