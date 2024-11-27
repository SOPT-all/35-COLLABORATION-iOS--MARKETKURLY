//
//  HomeRankingListGradientBackgroundView.swift
//  MarketKurly
//
//  Created by 최지석 on 11/27/24.
//

import UIKit
import SnapKit
import Then

final class HomeRankingListGradientBackgroundView: UICollectionReusableView {
    static let identifier = "HomeRankingListGradientBackgroundView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.gradientGray1.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
}
