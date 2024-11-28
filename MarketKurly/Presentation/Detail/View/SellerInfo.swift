//
//  SellerInfo.swift
//  MarketKurly
//
//  Created by 이세민 on 11/22/24.
//

import UIKit

import SnapKit

class SellerInfo: UIView {
    
    private var goods: Goods?
    
    private let deliveryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배송"
        label.font = MarketKurlyFont.bodyRegular14.font
        label.textColor = .gray6
        return label
    }()
    
    private let deliveryTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let sellerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "판매자"
        label.font = MarketKurlyFont.bodyRegular14.font
        label.textColor = .gray6
        return label
    }()
    
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "컬리"
        label.font = MarketKurlyFont.bodyMedium14.font
        label.textColor = .gray7
        return label
    }()
    
    private let deliveryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 58
        stackView.alignment = .leading
        return stackView
    }()
    
    private let sellerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 46
        stackView.alignment = .leading
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        
        stackView.layer.borderColor = UIColor.gray2.cgColor
        stackView.layer.borderWidth = 1.0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure(with: Goods.infoMockData[0])
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle(){
        self.backgroundColor = .kurlyWhite
    }
    
    private func setUI() {
        deliveryStackView.addArrangedSubview(deliveryTitleLabel)
        deliveryStackView.addArrangedSubview(deliveryTypeLabel)
        
        sellerStackView.addArrangedSubview(sellerTitleLabel)
        sellerStackView.addArrangedSubview(sellerNameLabel)
        
        mainStackView.addArrangedSubview(deliveryStackView)
        mainStackView.addArrangedSubview(sellerStackView)
        
        addSubview(mainStackView)
    }
    
    private func setLayout() {
        deliveryStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(17)
            $0.height.equalTo(50)
        }
        
        sellerStackView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(17)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(119)
        }
    }
    
    func configure(with goods: Goods) {
        if let deliveryType = goods.deliveryType {
            let fullText = "\(deliveryType)\n23시 전 주문 시 수도권/충청 내일 아침 7시 전 도착\n(그 외 지역 아침 8시 전 도착)"
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2
            
            let attributedText = NSMutableAttributedString(
                string: fullText,
                attributes: [
                    .font: MarketKurlyFont.captionRegular12.font,
                    .foregroundColor: UIColor.gray6,
                    .paragraphStyle: paragraphStyle
                ]
            )
            
            attributedText.addAttributes([
                .font: MarketKurlyFont.bodyMedium14.font,
                .foregroundColor: UIColor.gray7
            ], range: NSRange(location: 0, length: deliveryType.count))
            
            deliveryTypeLabel.attributedText = attributedText
            
        }
    }
}
