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
    var isMembersSectionVisible = false
    
    private let goodsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.captionSemiBold12.font
        label.textColor = .gray5
        label.text = "샛별배송"
        return label
    }()
    
    private let goodsNameLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyRegular18.font // bodySemiBold18 확인 필요
        label.textColor = .gray7
        label.text = "아삭하고 달콤한 황금사과 1.3kg (5~7입) [품종: 시나노골드]"
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
        label.text = "원산지: 국산"
        return label
    }()
    
    private let costPriceLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyMedium16.font
        label.textColor = .gray4
        
        let attributeString = NSAttributedString(
            string: "14,900원",
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        label.attributedText = attributeString
        
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
        label.font = MarketKurlyFont.bodyBold24.font // titleBold24 확인 필요
        label.textColor = .red
        label.text = "13%"
        return label
    }()
    
    private let discountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font // titleBold24 확인 필요
        label.textColor = .gray8
        
        let fullText = "12,900원"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: "원") {
            attributedString.addAttribute(
                .font,
                value: MarketKurlyFont.bodyBold16.font,
                range: NSRange(range, in: fullText)
            )
        }
        
        label.attributedText = attributedString
        return label
    }()
    
    lazy var membersButton: UIButton = {
        let button = UIButton()
        let icon = UIImage(named: "icn_goods_arrow_up")
        button.setImage(icon, for: .normal)
        button.tintColor = .mint3
        button.setTitle("멤버스 최대혜택가 ", for: .normal)
        button.setTitleColor(.mint3, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = MarketKurlyFont.bodyBold16.font
        
        return button
    }()
    
    private let membersRateLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font // titleBold24 확인 필요
        label.textColor = .mint3
        label.text = "26%"
        label.isHidden = true
        return label
    }()
    
    private let membersPriceLabel: UILabel = {
        let label = UILabel()
        label.font = MarketKurlyFont.bodyBold24.font // titleBold24 확인 필요
        label.textColor = .mint3
        
        let fullText = "10,900원"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: "원") { // bodyExtraBold14 확인 필요
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: NSRange(range, in: fullText))
        }
        
        label.attributedText = attributedString
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
        addSubviews(goodsImageView, deliveryLabel, goodsNameLabel, shareButton, originLabel, costPriceLabel, infoButton, discountRateLabel, discountPriceLabel, membersButton, membersRateLabel, membersPriceLabel, joinMembersButton)
    }
    
    private func setLayout() {
        goodsImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(491)
        }
        
        deliveryLabel.snp.makeConstraints{
            $0.top.equalTo(goodsImageView.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
            
        }
        
        goodsNameLabel.snp.makeConstraints{
            $0.top.equalTo(deliveryLabel.snp.bottom).offset(7)
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
}
