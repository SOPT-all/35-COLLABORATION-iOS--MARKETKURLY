//
//  GoodsInfo.swift
//  MarketKurly
//
//  Created by 이세민 on 11/28/24.
//

import UIKit

import SnapKit

class GoodsInfo: UIView {
    
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
        stackView.spacing = 10
        stackView.alignment = .leading
        
        stackView.layer.borderColor = UIColor.gray2.cgColor
        stackView.layer.borderWidth = 1.0
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
        self.backgroundColor = .white
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
            $0.top.equalTo(goodsInfoLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(119)
        }
    }
}

