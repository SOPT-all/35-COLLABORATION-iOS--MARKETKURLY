//
//  GoodsInfo.swift
//  MarketKurly
//
//  Created by 이세민 on 11/28/24.
//

import UIKit

import SnapKit

class GoodsInfo: UIView {
    
    private var goods: Goods?
    
    private let goodsInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "상품정보"
        label.font = MarketKurlyFont.bodyBold16.font
        label.textColor = .gray7
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        addSubviews(goodsInfoLabel, mainStackView)
    }
    
    private func setLayout() {
        goodsInfoLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(goodsInfoLabel.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().offset(-100)
            $0.width.equalToSuperview()
        }
    }
    
    private func addItemToStackView(title: String, value: String?) {
        guard let value = value else { return }
        
        let titleLabel = createLabel(text: title, font: MarketKurlyFont.bodyRegular14.font, textColor: .gray6)
        let valueLabel = createLabel(text: value, font: MarketKurlyFont.bodyMedium14.font, textColor: .gray7)
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 6
        horizontalStackView.alignment = .leading
        
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(valueLabel)
        
        mainStackView.addArrangedSubview(horizontalStackView)
        
        titleLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(80)
        }
        horizontalStackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func createLabel(text: String, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    // 데이터 연동
    func configure(with data: DetailDto) {
        let items: [(title: String, value: String?)] = [
            ("포장타입", data.packagingType),
            ("판매단위", data.sellingUnit),
            ("중량/용량", data.weight),
            ("알레르기정보", data.allergy),
            ("소비기한(또는 유통기한)정보", data.expiration),
            ("원산지", data.origin),
            ("당도", data.brix.map { "\($0) Brix 이상" }),
            ("안내사항", data.notification)
        ]
        
        for item in items {
            if let value = item.value, !value.isEmpty {
                addItemToStackView(title: item.title, value: value)
            }
        }
    }
}
