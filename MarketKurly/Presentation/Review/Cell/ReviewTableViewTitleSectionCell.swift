//
//  ReviewTableViewHeader.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/22/24.
//

import UIKit

import SnapKit
import Then

class ReviewTableViewTitleSectionCell: UITableViewCell {
    
    private let announcementLabel1 = UILabel().then {
        $0.font = MarketKurlyFont.captionMedium10.font
        $0.text = "공지"
        $0.textAlignment = .center
        $0.textColor = .gray7
        $0.backgroundColor = .gray2
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    private let announcementTitle1 = UILabel().then {
        $0.font = MarketKurlyFont.bodyRegular14.font
        $0.text = "[24년 11월 1주] 베스트 후기 선정 안내"
        $0.textColor = .gray7
    }
    
    private let announcementLabel2 = UILabel().then {
        $0.font = MarketKurlyFont.captionMedium10.font
        $0.text = "공지"
        $0.textAlignment = .center
        $0.textColor = .gray7
        $0.backgroundColor = .gray2
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    private let announcementTitle2 = UILabel().then {
        $0.font = MarketKurlyFont.bodyRegular14.font
        $0.text = "상품후기 적립금 정책 안내"
        $0.textColor = .gray7
    }
    
    private let imageReviewLabel = UILabel().then {
        $0.font = MarketKurlyFont.bodySemiBold14.font
        $0.text = "사진 후기"
        $0.textColor = .gray7
    }
    
    private let imageGridView = KurlyImageGridView()
    
    private let reviewCountLabel = UILabel()
    
    private let dividerLine = UIView().then {
        $0.backgroundColor = .gray2
    }
    
    private let reviewDropdownButton = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    private let reviewDropdownButtonLabel = UILabel()
    
    private let reviewDropdownButtonIcon = UIImageView(image: .icDropDown)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setLayout()
        setStyle()
    }

    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews(announcementLabel1, announcementTitle1, announcementLabel2, announcementTitle2, imageReviewLabel, imageGridView)
    }
    
    private func setLayout() {
        announcementLabel1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19.5)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(29)
            $0.height.equalTo(20)
        }
        
        announcementTitle1.snp.makeConstraints {
            $0.centerY.equalTo(announcementLabel1)
            $0.leading.equalTo(announcementLabel1.snp.trailing).offset(8)
        }
        
        announcementLabel2.snp.makeConstraints {
            $0.top.equalTo(announcementLabel1.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(29)
            $0.height.equalTo(20)
        }
        
        announcementTitle2.snp.makeConstraints {
            $0.centerY.equalTo(announcementLabel2)
            $0.leading.equalTo(announcementLabel2.snp.trailing).offset(8)
        }
        
        imageReviewLabel.snp.makeConstraints {
            $0.top.equalTo(announcementLabel2.snp.bottom).offset(24.5)
            $0.leading.equalToSuperview().offset(16)
        }
        
        imageGridView.snp.makeConstraints {
            $0.top.equalTo(imageReviewLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setStyle() {
    }
    
    func configure(imageUrls: [String]) {
        imageGridView.updateImages(with: imageUrls)
    }
}
