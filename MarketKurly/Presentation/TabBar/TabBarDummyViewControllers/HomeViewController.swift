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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }

    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubviews(
            titleLabel
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(60)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
}



