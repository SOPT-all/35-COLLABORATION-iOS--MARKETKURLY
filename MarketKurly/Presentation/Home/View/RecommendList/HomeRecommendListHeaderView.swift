//
//  HomeRecommendListHeaderView.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import SnapKit
import Then

final class HomeRecommendListHeaderView: UICollectionReusableView {
    
    static let identifier = "HomeRecommendListHeaderView"
    
    private let containerView = UIView()
    
    private let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "🎊 이 상품은 어때요?",
                                                  color: .gray8,
                                                  font: MarketKurlyFont.bodyBold16.font)  // FIXME: 폰트 변경 필요
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText = .makeAttributedString(text: "껄디님의 취향에 맞는 상품을 담아보세요",
                                                  color: .coolGray4,
                                                  font: MarketKurlyFont.bodySemiBold14.font)  // FIXME: 폰트 변경 필요
    }
    
    private let showMoreButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        
        // 이미지 설정
        let image = UIImage(named: "icn_home_arrow_right_purple")
        config.image = image
        config.imagePlacement = .trailing
        config.imagePadding = 0
        
        // 텍스트 설정
        config.attributedTitle = AttributedString(.makeAttributedString(text: "전체보기",
                                                                        color: .primary600,
                                                                        font: MarketKurlyFont.bodySemiBold14.font,
                                                                        textAlignment: .center))
        config.contentInsets = .zero
        
        $0.configuration = config
        $0.setContentHuggingPriority(.required, for: .horizontal)
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
                ),
                showMoreButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(103)
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(13)
            $0.trailing.equalTo(showMoreButton.snp.leading)
        }
        
        showMoreButton.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(titleStackView.snp.top)
            $0.trailing.equalToSuperview()
        }
    }
}
