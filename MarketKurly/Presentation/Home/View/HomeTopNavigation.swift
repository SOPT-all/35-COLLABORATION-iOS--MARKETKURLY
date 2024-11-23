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
        $0.image = UIImage(named: "img_home_logo")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .white
    }
    
    private let trailingLogoIconsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
    }
    
    private let notificationIconButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_home_notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = .white
    }
    
    private let cartIconButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_home_cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = .white
    }
    
    private let homeSwitchTab = HomeSwitchTab()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubview(
            containerView.addSubviews(
                leadingLogoIcon,
                homeSwitchTab,
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
        
        homeSwitchTab.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
            $0.width.equalTo(135)
            $0.height.equalTo(28)
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
    
    
    private func bindAction() {
        homeSwitchTab.addTarget(self, action: #selector(tabIndexDidChange(_:)), for: .valueChanged)
    }

    @objc private func tabIndexDidChange(_ sender: HomeSwitchTab) {
        updateTopNavigationUI(with: sender.selectedIndex)
    }
    
    private func updateTopNavigationUI(with index: Int) {
        if index == 0 {
            containerView.backgroundColor = .primary600
            leadingLogoIcon.tintColor = .white
            notificationIconButton.tintColor = .white
            cartIconButton.tintColor = .white
        } else {
            containerView.backgroundColor = .white
            leadingLogoIcon.tintColor = .primary600
            notificationIconButton.tintColor = .black
            cartIconButton.tintColor = .black
        }
    }
}
