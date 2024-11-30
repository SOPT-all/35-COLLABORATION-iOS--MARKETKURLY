//
//  TopNavigation.swift
//  MarketKurly
//
//  Created by 최지석 on 11/30/24.
//

import UIKit
import Then
import SnapKit

protocol TopNavigationDelegate: AnyObject {
    func backButtonDidTap()
    func trailingPrimaryButtonDidTap()
    func trailingSecondaryButtonDidTap()
}


final class TopNavigation: UIView {
    
    weak var delegate: TopNavigationDelegate?
    
    private let containerView = UIView().then {
        $0.backgroundColor = .kurlyWhite
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_back_button"), for: .normal)
    }
    
    private let trailingButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alignment = .center
    }
    
    private let primaryIconButton = UIButton()
    
    private let secondaryIconButton = UIButton()
    
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    public init(shouldCenterTitle: Bool = false) {
        super.init(frame: .zero)
        
        makeUI(shouldCenterTitle: shouldCenterTitle)
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI(shouldCenterTitle: Bool) {
        addSubview(
            containerView.addSubviews(
                backButton,
                titleLabel,
                trailingButtonStackView.addArrangedSubviews(
                    primaryIconButton,
                    secondaryIconButton
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        trailingButtonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        primaryIconButton.snp.makeConstraints {
            $0.size.equalTo(48)
        }
        
        secondaryIconButton.snp.makeConstraints {
            $0.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            if shouldCenterTitle {
                $0.centerX.equalToSuperview()
            } else {
                $0.leading.equalTo(backButton.snp.trailing)
                $0.trailing.equalTo(trailingButtonStackView.snp.leading)
            }
            $0.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    
    private func bindAction() {
        backButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            delegate?.backButtonDidTap()
        }, for: .touchUpInside)
        
        primaryIconButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            delegate?.trailingPrimaryButtonDidTap()
        }, for: .touchUpInside)
        
        secondaryIconButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            delegate?.trailingSecondaryButtonDidTap()
        }, for: .touchUpInside)
    }
    
    
    public func setUI(title: String?,
                      primaryIcon: String?,
                      secondaryIcon: String?) {
        
        clearUI()
        
        if let title {
            titleLabel.attributedText = .makeAttributedString(text: title,
                                                              color: .gray8,
                                                              font: MarketKurlyFont.bodyBold16.font,
                                                              textAlignment: .center,
                                                              lineBreakMode: .byTruncatingTail)
        }
        
        if let primaryIcon {
            primaryIconButton.setImage(UIImage(named: primaryIcon), for: .normal)
            primaryIconButton.isHidden = false
        }
        
        if let secondaryIcon {
            secondaryIconButton.setImage(UIImage(named: secondaryIcon), for: .normal)
            secondaryIconButton.isHidden = false
        }
    }
    
    
    private func clearUI() {
        titleLabel.attributedText = nil
        primaryIconButton.setImage(nil, for: .normal)
        primaryIconButton.isHidden = true
        secondaryIconButton.setImage(nil, for: .normal)
        secondaryIconButton.isHidden = true
    }
}
