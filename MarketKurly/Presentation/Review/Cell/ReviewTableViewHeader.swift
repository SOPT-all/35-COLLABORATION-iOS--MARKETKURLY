//
//  ReviewTableViewHeader.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/27/24.
//

import UIKit

import SnapKit
import Then

class ReviewTableViewHeader: UIView {
    private let reviewCountLabel = UILabel().then {
        $0.textColor = .gray7
        $0.font = MarketKurlyFont.bodySemiBold14.font
    }
    
    private let reviewDropdownButton = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    private let reviewDropdownButtonLabel = UILabel().then {
        $0.text = "최신순"
        $0.font = MarketKurlyFont.bodyMedium14.font
        $0.textColor = .gray7
    }
    
    private let reviewDropdownButtonIcon = UIImageView(image: .icDropDown)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayout()
        
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubviews(reviewCountLabel, reviewDropdownButton)
        reviewDropdownButton.addArrangedSubviews(reviewDropdownButtonLabel, reviewDropdownButtonIcon)
    }

    private func setLayout() {
        reviewCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.bottom.equalToSuperview().offset(-19)
            $0.leading.equalToSuperview().offset(16)
        }
        
        reviewDropdownButton.snp.makeConstraints {
            $0.centerY.equalTo(reviewCountLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(count: Int, selectedSort: String) {
        let formattedCount = NumberFormatter().then {
            $0.numberStyle = .decimal
        }.string(from: NSNumber(value: count))
        reviewCountLabel.text = "총 \(formattedCount ?? "0")개"
        
        reviewDropdownButtonLabel.text = selectedSort
    }
}
