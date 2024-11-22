//
//  HomeViewController.swift
//  MarketKurly
//
//  Created by 최지석 on 11/22/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "Home",
                                                  color: .black,
                                                  font: MarketKurlyFont.bodyBold16.font)
    }
    
    private let topNavigation = HomeTopNavigation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }

    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubviews(
            topNavigation
        )
        
        topNavigation.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(88)  // FIXME: top-safe-area 고려 필요
        }
    }
}



