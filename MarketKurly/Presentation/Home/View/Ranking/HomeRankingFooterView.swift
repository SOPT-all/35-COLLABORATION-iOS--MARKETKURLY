//
//  HomeRankingFooterView.swift
//  MarketKurly
//
//  Created by 최지석 on 11/27/24.
//

import UIKit
import SnapKit
import Then

final class HomeRankingFooterView: UICollectionReusableView {
    
    static let identifier = "HomeRankingFooterView"
    
    private let containerView = UIView()
    
    private let showMoreButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        
        let image = UIImage(named: "icn_home_arrow_right_black")
        config.image = image
        config.imagePadding = 1 // 이미지와 텍스트 사이 간격
        config.imagePlacement = .trailing
        
        // 텍스트 설정
        config.attributedTitle = AttributedString(.makeAttributedString(text: "담기",
                                                                        color: .gray7,
                                                                        font: MarketKurlyFont.captionMedium12.font,
                                                                        textAlignment: .center))
        
        // 테두리 및 border 설정
        config.background.strokeWidth = 1
        config.background.strokeColor = UIColor.coolGray2
        config.background.cornerRadius = 4
        
        $0.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(
            containerView.addSubviews(
                showMoreButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        showMoreButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(23)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
}


