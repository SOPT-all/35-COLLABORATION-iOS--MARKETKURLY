//
//  WishListTableViewCell.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/28/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class WishListTableViewCell: UITableViewCell {
    
    private let productImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "[프레지덩] 포션 버터 비가염 (10g X 20개입)"
        $0.textColor = .gray7
        $0.font = MarketKurlyFont.bodyMedium14.font
        $0.numberOfLines = 1
    }
    
    private let discountLabel = UILabel().then {
        $0.text = "19%"
        $0.textColor = .kurlyRed
        $0.font = MarketKurlyFont.bodyBold16.font
    }
    
    private let priceLabel = UILabel().then {
        $0.text = "7,273원"
        $0.textColor = .gray7
        $0.font = MarketKurlyFont.bodyBold16.font
    }
    
    private let defaultPriceLabel = UILabel().then {
        let priceText = "8,980원"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: MarketKurlyFont.captionRegular12.font,
            .foregroundColor: UIColor.gray3,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributedString = NSAttributedString(string: priceText, attributes: attributes)
        
        $0.attributedText = attributedString
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.gray7, for: .normal)
        $0.titleLabel?.font = MarketKurlyFont.bodyMedium14.font
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray3.cgColor
    }
    
    private let addButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("담기")
        attributedTitle.font = MarketKurlyFont.bodyMedium14.font
        configuration.attributedTitle = attributedTitle
        configuration.baseForegroundColor = .primary600
        configuration.image = UIImage(named: "ic_cart_18")
        configuration.imagePlacement = .leading
        $0.configuration = configuration
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.primary600.cgColor
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
        addSubviews(productImageView, titleLabel, discountLabel, priceLabel, defaultPriceLabel, buttonStackView)
        buttonStackView.addArrangedSubviews(deleteButton, addButton)
    }
    
    private func setLayout() {
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(87)
            $0.height.equalTo(113)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView)
            $0.leading.equalTo(productImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(discountLabel)
            $0.leading.equalTo(discountLabel.snp.trailing).offset(5)
        }
        
        defaultPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(4)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(productImageView.snp.bottom)
            $0.leading.equalTo(productImageView.snp.trailing).offset(16)
            $0.height.equalTo(36)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(data: WishListModel){
        guard let url = URL(string: data.imageURL) else { return }
        productImageView.kf.setImage(with: url)
        titleLabel.text = data.title
        discountLabel.text = data.discount
        priceLabel.text = data.price
        defaultPriceLabel.text = data.defaultPrice
    }
}
