//
//  ReviewTableViewCell.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/22/24.
//

import UIKit

import SnapKit
import Then

class ReviewTableViewCell: UITableViewCell {
    private let advertisementLabel = UILabel().then {
        $0.text = "광고"
        $0.font = MarketKurlyFont.captionMedium10.font
        $0.textAlignment = .center
        $0.textColor = .white
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.backgroundColor = .primary600
        $0.layer.masksToBounds = true
        $0.numberOfLines = 1
        $0.contentMode = .center
    }
    
    private let nameLabel = UILabel().then {
        $0.font = MarketKurlyFont.captionMedium10.font
        $0.textColor = .gray7
    }
    
    private let imageGridView = KurlyImageGridView()
    
    private let reviewLabel = UILabel().then {
        $0.font = MarketKurlyFont.bodyRegular14.font
        $0.textColor = .gray7
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let discriptionLabel = UILabel().then {
        $0.font = MarketKurlyFont.captionRegular12.font
        $0.textColor = .gray5
        $0.textAlignment = .left
    }
    
    private let dateLabel = UILabel().then {
        $0.font = MarketKurlyFont.captionRegular12.font
        $0.textColor = .gray4
    }
    
    private let ratingStarView = RatingStarView()
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews(advertisementLabel, nameLabel, imageGridView, reviewLabel, discriptionLabel, dateLabel, ratingStarView, dividerView)
    }
    
    private func setLayout() {
        advertisementLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(37)
            $0.height.equalTo(18)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(advertisementLabel)
            $0.leading.equalTo(advertisementLabel.snp.trailing).offset(6)
        }
        
        discriptionLabel.snp.makeConstraints {
            $0.top.equalTo(advertisementLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        imageGridView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(discriptionLabel.snp.bottom).offset(9)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(imageGridView.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(16)
        }
        
        ratingStarView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(dividerView).inset(16)
        }
        
        dividerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    func configure(data: ReviewData){
        if(!data.isAdvertisement){
            advertisementLabel.snp.makeConstraints {
                $0.width.equalTo(0)
            }
            nameLabel.snp.makeConstraints {
                $0.leading.equalTo(advertisementLabel.snp.trailing)
            }
        }
        nameLabel.text = data.name
        discriptionLabel.text = data.discription
        imageGridView.updateImages(with: data.imageUrls)
        reviewLabel.text = data.review
        dateLabel.text = data.date
        ratingStarView.updateRating(Int(data.rating))
    }
}
