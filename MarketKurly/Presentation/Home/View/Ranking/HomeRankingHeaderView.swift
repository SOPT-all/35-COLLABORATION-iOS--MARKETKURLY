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
                                                  font: MarketKurlyFont.titleEmoji22.font)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "가장 인기있는 상품만 모아보세요!",
                                                  color: .coolGray4,
                                                  font: MarketKurlyFont.bodySemiBold14.font)  // FIXME: 폰트 변경 필요
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
            $0.top.equalToSuperview().inset(23)
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview().inset(46)
        }
    }
}

