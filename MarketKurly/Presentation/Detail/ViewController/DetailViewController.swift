//
//  DetailViewController.swift
//  MarketKurly
//
//  Created by 이세민 on 11/19/24.
//

import UIKit

import SnapKit

class DetailViewController: UIViewController {
    
    private var isWished = false
    
    private let priceInfo = PriceInfo()
    private let sellerInfo = SellerInfo()
    private let relatedGoods = RelatedGoods()
    private let goodsInfo = GoodsInfo()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var snackBar: UIButton  = {
        let button = UIButton()
        button.backgroundColor = .gray7
        button.layer.cornerRadius = 4
        button.isHidden = true
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "찜한 상품에 추가되었습니다."
        descriptionLabel.textColor = .kurlyWhite
        descriptionLabel.font = MarketKurlyFont.captionMedium12.font
        
        let goToWishListLabel = UILabel()
        goToWishListLabel.text = "찜한 상품으로 가기"
        goToWishListLabel.textColor = .primary300
        goToWishListLabel.font = MarketKurlyFont.captionMedium12.font
        
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, goToWishListLabel])
        stackView.axis = .horizontal
        stackView.spacing = 61
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        button.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        return button
    }()
    
    private let wishButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_save_default"), for: .normal)
        button.layer.borderColor = UIColor.gray3.cgColor
        button.backgroundColor = .kurlyWhite
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let purchaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("구매하기", for: .normal)
        button.setTitleColor(.kurlyWhite, for: .normal)
        button.backgroundColor = .primary600
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setStyle()
        setUI()
        setLayout()
        
        wishButton.addTarget(self, action: #selector(didTapWishButton), for: .touchUpInside)
        
        fetchDetailData()
    }
    
    private func fetchDetailData() {
        let productId = 12
        
        DetailApi.shared.getDetailData(productId: productId) { result in
            switch result {
            case .success(let detailDto):
                self.priceInfo.configure(with: detailDto.data)
                self.sellerInfo.configure(with: detailDto.data)
                self.goodsInfo.configure(with: detailDto.data)
            case .failure(let error):
                print("Error fetching detail data: \(error)")
            }
        }
    }
    
    private func setDelegate() {
        priceInfo.delegate = self
    }
    
    private func setStyle() {
        self.view.backgroundColor = .gray2
    }
    
    private func setUI() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(priceInfo, sellerInfo, relatedGoods, goodsInfo)
        contentView.addSubviews(snackBar, wishButton, purchaseButton)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        priceInfo.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        sellerInfo.snp.makeConstraints{
            if priceInfo.isMembersSectionVisible {
                $0.top.equalTo(priceInfo.joinMembersButton.snp.bottom).offset(19.08)
            } else {
                $0.top.equalTo(priceInfo.membersButton.snp.bottom).offset(10)
            }
            $0.leading.trailing.equalToSuperview()
        }
        
        relatedGoods.snp.makeConstraints{
            $0.top.equalTo(sellerInfo.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
        }
        
        goodsInfo.snp.makeConstraints{
            $0.top.equalTo(relatedGoods.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentView)
        }
        
        snackBar.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(wishButton.snp.top).offset(-17)
            $0.width.equalTo(329)
            $0.height.equalTo(42)
            
        }
        
        wishButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(11)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            $0.width.equalTo(51)
            $0.height.equalTo(49)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.leading.equalTo(wishButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-11)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            $0.width.equalTo(294)
            $0.height.equalTo(49)
        }
    }
    
    @objc private func didTapWishButton() {
        isWished.toggle()
        
        if isWished {
            wishButton.setImage(UIImage(named: "icn_save_activate"), for: .normal)
            snackBar.isHidden = false
            snackBar.alpha = 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.snackBar.alpha = 0.0
                }) { _ in
                    self.snackBar.isHidden = true
                }
            }
        } else {
            wishButton.setImage(UIImage(named: "icn_save_default"), for: .normal)
        }
    }
}

extension DetailViewController: PriceInfoDelegate {
    
    func didTapMembersButton(isMembersSectionVisible: Bool) {
        sellerInfo.snp.removeConstraints()
        
        sellerInfo.snp.makeConstraints {
            if priceInfo.isMembersSectionVisible {
                $0.top.equalTo(priceInfo.joinMembersButton.snp.bottom).offset(19.08)
            } else {
                $0.top.equalTo(priceInfo.membersButton.snp.bottom).offset(10)
            }
            $0.leading.trailing.equalToSuperview()
        }
        
        self.view.layoutIfNeeded()
    }
}

