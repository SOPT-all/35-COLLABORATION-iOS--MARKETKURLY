//
//  HomeRankingListCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/27/24.
//

import UIKit
import SnapKit
import Then

final class HomeRankingListCell: UICollectionViewCell {
    
    static let identifier = "HomeRankingListCell"
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let productImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .coolGray2
    }
    
    private let rankingLabel = UILabel()
    
    private let productInfoContainerView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 14
    }
    
    private let productContentsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 1
    }
    
    private let productNameLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    private let salePriceStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 4
    }
    
    private let discountRateLabel = UILabel()
    
    private let salePriceLabel = UILabel()
    
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
                productInfoContainerView.addArrangedSubviews(
                    rankingLabel,
                    productContentsStackView.addArrangedSubviews(
                        productNameLabel,
                        salePriceStackView.addArrangedSubviews(
                            discountRateLabel,
                            salePriceLabel
                        )
                    )
                ),
                cartButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints {
            $0.height.equalTo(225)
            $0.width.equalTo(183)
            $0.top.left.right.equalToSuperview()
        }
        
        cartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(30)
        }
        
        productInfoContainerView.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom)
            $0.bottom.equalTo(cartButton.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    
    public func setUI(with item: HomeRankingListItem, cellIndex: Int) {
        
        if let productImage = item.image {
            let imageURL = URL(string: productImage)
            productImageView.kf.setImage(with: imageURL)
        }
        
        rankingLabel.attributedText = .makeAttributedString(text: "\(cellIndex)",
                                                            color: .gray7,
                                                            font: MarketKurlyFont.titleBold32.font)
        
        if let productName = item.name {
            productNameLabel.attributedText = .makeAttributedString(text: productName,
                                                                    color: .gray8,
                                                                    font: MarketKurlyFont.bodySemiBold14.font)  // FIXME: Medium 폰트 추가 필요
        }
        
        if let discountRate = item.discount {
            discountRateLabel.attributedText = .makeAttributedString(text: "\(discountRate)%",
                                                                     color: .red,
                                                                     font: MarketKurlyFont.bodySemiBold14.font)
        }
        
        if let salePrice = item.price,
           let formattedSalePrice = Formatter.currency.string(for: salePrice) {
            salePriceLabel.attributedText = .makeAttributedString(text: formattedSalePrice + "원",
                                                                  color: .gray8,
                                                                  font: MarketKurlyFont.bodySemiBold14.font)
        }
    }
    
    
    private func clearUI() {
        productImageView.image = nil
        productNameLabel.attributedText = nil
        discountRateLabel.attributedText = nil
        salePriceLabel.attributedText = nil
    }
}

