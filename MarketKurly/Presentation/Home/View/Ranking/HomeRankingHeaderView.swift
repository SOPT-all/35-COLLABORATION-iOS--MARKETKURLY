//
//  HomeRankingHeaderView.swift
//  MarketKurly
//
//  Created by 최지석 on 11/27/24.
//

import UIKit
import SnapKit
import Then

final class HomeRankingHeaderView: UICollectionReusableView {
    
    static let identifier = "HomeRankingHeaderView"
    
    private let containerView = UIView()
    
    private let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 4
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "🏆 실시간 인기 랭킹 🏆",
                                                  color: .gray8,
                                                  font: MarketKurlyFont.bodySemiBold18.font,
                                                  textAlignment: .center)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "가장 인기있는 상품만 모아보세요!",
                                                  color: .coolGray4,
                                                  font: MarketKurlyFont.bodyMedium14.font)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(
            containerView.addSubviews(
                titleStackView.addArrangedSubviews(
                    titleLabel,
                    descriptionLabel
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

