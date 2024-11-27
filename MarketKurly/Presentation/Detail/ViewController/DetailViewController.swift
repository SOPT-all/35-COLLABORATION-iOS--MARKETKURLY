//
//  DetailViewController.swift
//  MarketKurly
//
//  Created by 이세민 on 11/19/24.
//

import UIKit

import SnapKit

class DetailViewController: UIViewController, PriceInfoDelegate {
    
    private let priceInfo = PriceInfo()
    private let sellerInfo = SellerInfo()
    private let relatedGoods = RelatedGoods()
    private let goodsInfo = GoodsInfo()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let wishButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icn_save_default"), for: .normal)
        button.layer.borderColor = UIColor.gray3.cgColor
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let purchaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("구매하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primary600
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
        
        priceInfo.delegate = self
    }
    
    private func setStyle() {
        self.view.backgroundColor = .gray2
    }
    
    private func setUI() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(priceInfo, sellerInfo, relatedGoods, goodsInfo)
        
        contentView.addSubviews(wishButton, purchaseButton)
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

