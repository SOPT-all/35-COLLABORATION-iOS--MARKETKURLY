//
//  PriceInfo.swift
//  MarketKurly
//
//  Created by 이세민 on 11/28/24.
//

import UIKit
import SnapKit

protocol PriceInfoDelegate: AnyObject {
    func didTapMembersButton(isMembersSectionVisible: Bool)
}

class PriceInfo: UIView {
    
    weak var delegate: PriceInfoDelegate?
    private var goods: Goods?
    var isMembersSectionVisible = false
    
    private let goodsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let deliveryTypeLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.captionSemiBold12.font
        label.textColor = .gray5
        return label
    }()
    
    private let goodsNameLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyRegular18.font
        label.textColor = .gray7
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icn_goods_share"), for: .normal)
        button.tintColor = .gray7
        return button
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyRegular18.font
        label.textColor = .gray7
        return label
    }()
    
    private let costPriceLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyMedium16.font
        label.textColor = .gray4
        return label
    }()
    
    private var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icn_description_info"), for: .normal)
        button.tintColor = .gray4
        return button
    }()
    
    private let discountRateLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font
        label.textColor = .red
        return label
    }()
    
    private let discountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font
        label.textColor = .gray8
        return label
    }()
    
    lazy var membersButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_goods_arrow_up"), for: .normal)
        button.tintColor = .mint3
        button.setTitle("멤버스 최대혜택가 ", for: .normal)
        button.setTitleColor(.mint3, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = MarketKurlyFont.bodyBold16.font
        return button
    }()
    
    private let membersRateLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font
        label.textColor = .mint3
        label.isHidden = true
        return label
    }()
    
    private let membersPriceLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font
        label.textColor = .mint3
        label.isHidden = true
        return label
    }()
    
    let joinMembersButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = MarketKurlyFont.captionSemiBold12.font
        button.setTitleColor(.gray7, for: .normal)
        button.backgroundColor = .mint1
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "Mint3")?.cgColor
        
        let leftIcon = UIImageView(image: UIImage(named: "icn_goods_members"))
        leftIcon.contentMode = .scaleAspectFit
        
        let rightIcon = UIImageView(image: UIImage(named: "icn_goods_arrow_right"))
        rightIcon.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [leftIcon, button.titleLabel!, rightIcon])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        
        button.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(button.snp.centerX)
            $0.centerY.equalTo(button.snp.centerY)
        }
        
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure(with: Goods.infoMockData[0])
        
        setStyle()
        setUI()
        setLayout()
        
        updateJoinMembersButtonText()
        membersButton.addTarget(self, action: #selector(membersButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle(){
        self.backgroundColor = .white
    }
    
    private func setUI() {
        addSubviews(goodsImageView, deliveryTypeLabel, goodsNameLabel, shareButton, originLabel, costPriceLabel, infoButton, discountRateLabel, discountPriceLabel, membersButton, membersRateLabel, membersPriceLabel, joinMembersButton)
    }
    
    private func setLayout() {
        goodsImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(491)
        }
        
        deliveryTypeLabel.snp.makeConstraints{
            $0.top.equalTo(goodsImageView.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
        }
        
        goodsNameLabel.snp.makeConstraints{
            $0.top.equalTo(deliveryTypeLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(309)
        }
        
        shareButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(goodsNameLabel)
        }
        
        originLabel.snp.makeConstraints {
            $0.top.equalTo(goodsNameLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(16)
        }
        
        costPriceLabel.snp.makeConstraints {
            $0.top.equalTo(originLabel.snp.bottom).offset(13.82)
            $0.leading.equalToSuperview().offset(16)
        }
        
        infoButton.snp.makeConstraints{
            $0.leading.equalTo(costPriceLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(costPriceLabel)
            $0.width.height.equalTo(18)
        }
        
        discountRateLabel.snp.makeConstraints {
            $0.top.equalTo(costPriceLabel.snp.bottom).offset(3.37)
            $0.leading.equalToSuperview().offset(16)
        }
        
        discountPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(discountRateLabel.snp.trailing).offset(11)
            $0.centerY.equalTo(discountRateLabel)
        }
        
        membersButton.snp.makeConstraints {
            $0.top.equalTo(discountRateLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(16)
        }
        
        membersRateLabel.snp.makeConstraints {
            $0.top.equalTo(membersButton.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(16)
        }
        
        membersPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(membersRateLabel.snp.trailing).offset(11)
            $0.centerY.equalTo(membersRateLabel)
        }
        
        joinMembersButton.snp.makeConstraints{
            $0.top.equalTo(membersRateLabel.snp.bottom).offset(4.37)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-18.08)
            $0.width.equalTo(344)
            $0.height.equalTo(44)
        }
    }
    
    func updateJoinMembersButtonText() {
        if let fullText = membersPriceLabel.text {
            let buttonText = "멤버스 가입하고 \(fullText) 에 구매하기"
            
            let attributedString = NSMutableAttributedString(string: buttonText)
            if let range = buttonText.range(of: fullText) {
                attributedString.addAttribute(.foregroundColor, value: UIColor.mint3, range: NSRange(range, in: buttonText))
            }
            
            joinMembersButton.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    @objc private func membersButtonTapped() {
        isMembersSectionVisible.toggle()
        
        UIView.animate(withDuration: 0.3) {
            [self.membersRateLabel, self.membersPriceLabel, self.joinMembersButton]
                .forEach { $0.isHidden = !self.isMembersSectionVisible }
            
            let icon = UIImage(named: self.isMembersSectionVisible ? "icn_goods_arrow_down" : "icn_goods_arrow_up")
            self.membersButton.setImage(icon, for: .normal)
        }
        
        delegate?.didTapMembersButton(isMembersSectionVisible: isMembersSectionVisible)
    }
    
    func configure(with goods: Goods) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        func formattedPrice(_ price: Int) -> String {
            if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
                return formattedPrice + "원"
            }
            return "\(price)원"
        }
        
        if let goodsName = goods.goodsName as String?,
           let origin = goods.origin as String?,
           let costPrice = goods.costPrice as Int?,
           let discountRate = goods.discountRate as Int?,
           let discountPrice = goods.discountPrice as Int?,
           let membersRate = goods.membersRate as Int?,
           let membersPrice = goods.membersPrice as Int? {
            
            goodsNameLabel.text = goodsName
            originLabel.text = "원산지: \(origin)"
            
            let costPriceText = formattedPrice(costPrice)
            costPriceLabel.attributedText = NSAttributedString(string: costPriceText, attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ])
            
            discountRateLabel.text = "\(discountRate)%"
            discountPriceLabel.text = formattedPrice(discountPrice)
            membersRateLabel.text = "\(membersRate)%"
            membersPriceLabel.text = formattedPrice(membersPrice)
            
        } else {
            goodsNameLabel.text = "정보 없음"
            originLabel.text = "정보 없음"
            discountRateLabel.text = "정보 없음"
            discountPriceLabel.text = "정보 없음"
            membersRateLabel.text = "정보 없음"
            membersPriceLabel.text = "정보 없음"
        }
    }
}

