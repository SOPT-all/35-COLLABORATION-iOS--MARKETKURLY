//
//  HomeWishListCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class HomeWishListCell: UICollectionViewCell {
    
    private let containerView = UIView()
    
    private let productImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .coolGray2
    }
    
    private let productNameLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    private let cartButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        
        let image = UIImage(named: "icon_home_cart_small")
        config.image = image
        config.imagePadding = 1 // 이미지와 텍스트 사이 간격
        
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
    
    private let strikePriceLabel = UILabel()
    
    private let strikePriceView = UIView().then {
        $0.backgroundColor = .coolGray3
    }
    
    private let salePriceStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 4
    }
    
    private let discountRateLabel = UILabel()
    
    private let salePriceLabel = UILabel()
    
    private let reviewStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alignment = .bottom
    }
    
    private let reviewIconImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_home_comment")
    }
    
    private let reviewCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    private func makeUI() {
        contentView.addSubview(
            containerView.addSubviews(
                productImageView,
                cartButton,
                productNameLabel,
                strikePriceLabel,
                strikePriceView,
                salePriceStackView.addArrangedSubviews(
                    discountRateLabel,
                    salePriceLabel
                ),
                reviewStackView.addArrangedSubviews(
                    reviewIconImageView,
                    reviewCountLabel
                )
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints {
            $0.height.equalTo(188)
            $0.width.equalTo(145)
            $0.top.left.right.equalToSuperview()
        }
        
        cartButton.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(cartButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
        }
        
        strikePriceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(2)
            $0.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        
        strikePriceView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(strikePriceLabel.snp.horizontalEdges)
            $0.height.equalTo(1)
            $0.centerY.equalTo(strikePriceLabel.snp.centerY)
        }
        
        salePriceStackView.snp.makeConstraints {
            $0.top.equalTo(strikePriceLabel.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview()
        }
        
        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(salePriceStackView.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview()
        }
        
        reviewIconImageView.snp.makeConstraints {
            $0.size.equalTo(18)
        }
    }
    
    
    public func setUI(with item: HomeWishListItem) {
        
        if let productImage = item.image {
            let imageURL = URL(string: productImage)
            productImageView.kf.setImage(with: imageURL)
        }
        
        if let productName = item.name {
            productNameLabel.attributedText = .makeAttributedString(text: productName,
                                                                    color: .gray8,
                                                                    font: MarketKurlyFont.bodyMedium14.font)
        }
        
        if let discountPrice = item.discountPrice,
           let formattedDiscountPrice = Formatter.currency.string(for: discountPrice) {
            strikePriceLabel.attributedText = .makeAttributedString(text: formattedDiscountPrice + "원",
                                                                    color: .coolGray3,
                                                                    font: MarketKurlyFont.captionRegular12.font)
        }
        
        if let discountRate = item.discount {
            discountRateLabel.attributedText = .makeAttributedString(text: "\(discountRate)%",
                                                                     color: .kurlyRed,
                                                                     font: MarketKurlyFont.bodyBold14.font)
        }
        
        if let salePrice = item.price,
           let formattedSalePrice = Formatter.currency.string(for: salePrice) {
            salePriceLabel.attributedText = .makeAttributedString(text: formattedSalePrice + "원",
                                                                  color: .gray8,
                                                                  font: MarketKurlyFont.bodyBold14.font)
        }
        
        if let reviewCount = item.reviewCount {
            reviewCountLabel.attributedText = .makeAttributedString(text: "\(reviewCount)+",
                                                                     color: .coolGray3,
                                                                     font: MarketKurlyFont.captionRegular12.font)
        }
    }
    
    
    private func clearUI() {
        productImageView.image = nil
        productNameLabel.attributedText = nil
        strikePriceLabel.attributedText = nil
        discountRateLabel.attributedText = nil
        salePriceLabel.attributedText = nil
        reviewCountLabel.attributedText = nil
    }
}

