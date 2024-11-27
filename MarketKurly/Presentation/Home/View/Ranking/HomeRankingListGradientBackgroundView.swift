//
//  HomeRankingListGradientBackgroundView.swift
//  MarketKurly
//
//  Created by 최지석 on 11/27/24.
//

import UIKit

final class HomeRankingListGradientBackgroundView: UICollectionReusableView {
    
    static let identifier = "HomeRankingGradientBackgroundView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemGray6.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        (layer.sublayers?.first as? CAGradientLayer)?.frame = bounds
    }
}
