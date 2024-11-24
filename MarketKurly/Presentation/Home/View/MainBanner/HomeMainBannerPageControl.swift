//
//  HomeMainBannerPageControl.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import Then
import SnapKit

final class HomeMainBannerPageControl: UIView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .black18
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let pageControlLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubviews(
            containerView.addSubviews(
                pageControlLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        pageControlLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(7)
        }
    }
    
    
    public func setUI(currentPage: Int, totalPageCount: Int) {
        clearUI()
        
        pageControlLabel.attributedText = .makeAttributedString(text: "\(currentPage) / \(totalPageCount)",
                                                                color: .white,
                                                                font: MarketKurlyFont.captionMedium12.font,
                                                                textAlignment: .center)
    }
    
    
    private func clearUI() {
        pageControlLabel.attributedText = nil
    }
}
