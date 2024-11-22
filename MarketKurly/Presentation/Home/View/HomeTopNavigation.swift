//
//  TopNavigation.swift
//  MarketKurly
//
//  Created by 최지석 on 11/23/24.
//

import UIKit
import Then
import SnapKit

final class HomeTopNavigation: UIView {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .primary600
    }
    
    private let leadingLogoIcon = UIImageView().then {
        $0.image = UIImage(named: "img_home_logo")
    }
    
    private let trailingLogoIconsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
    }
    
    private let notificationIconButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_home_notification"), for: .normal)
        $0.backgroundColor = .clear
    }
    
    private let cartIconButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_home_cart"), for: .normal)
        $0.backgroundColor = .clear
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubview(
            containerView.addSubviews(
                leadingLogoIcon,
                // TODO: centerSwitchTab,
                trailingLogoIconsStackView.addArrangedSubviews(
                    notificationIconButton,
                    cartIconButton
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        leadingLogoIcon.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(32)
            $0.leading.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-6)
        }
        
        trailingLogoIconsStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-14)
            $0.bottom.equalToSuperview().offset(-2)
        }
        
        notificationIconButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        cartIconButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }
}
