//
//  DetailTopNavigation.swift
//  MarketKurly
//
//  Created by 최지석 on 11/30/24.
//

import UIKit
import Then
import SnapKit

protocol DetailTopNavigationDelegate: AnyObject {
    func backButtonDidTap()
}


final class DetailTopNavigation: UIView {
    
    weak var delegate: DetailTopNavigationDelegate?
    
    private let containerView = UIView().then {
        $0.backgroundColor = .primary600
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_back_button"), for: .normal)
    }
    
    private let cartButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_cart_40"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
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
                backButton,
                titleLabel,
                cartButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.leading.equalToSuperview().inset(2)
            $0.bottom.equalToSuperview()
        }
        
        cartButton.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.trailing.equalToSuperview().inset(2)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing)
            $0.trailing.equalTo(cartButton.snp.leading).offset(-6)
            $0.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    
    private func bindAction() {
        backButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            delegate?.backButtonDidTap()
        }, for: .touchUpInside)
    }
    
    
    public func setUI(title: String?) {
        
        clearUI()
        
        if let title {
            titleLabel.attributedText = .makeAttributedString(text: title,
                                                              color: .gray8,
                                                              font: MarketKurlyFont.titleBody18.font,
                                                              lineBreakMode: .byTruncatingTail)
        }
    }
    
    
    private func clearUI() {
        titleLabel.attributedText = nil
    }
}

