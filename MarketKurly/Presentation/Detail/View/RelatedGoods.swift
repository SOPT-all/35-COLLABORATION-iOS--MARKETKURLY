//
//  RelatedGoods.swift
//  MarketKurly
//
//  Created by 이세민 on 11/26/24.
//

import UIKit

import SnapKit

class RelatedGoods: UIView {
    
    private let tableView = UITableView()
    private let goodsList = Goods.relatedMockData
    
    private let otherCustomersViewedLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 고객이 함께 본 상품"
        label.font = MarketKurlyFont.bodyBold16.font
        label.textColor = .gray7
        return label
    }()
    
    private var nextGoodsButton: UIButton = {
        let button = UIButton()
        let icon = UIImage(named: "icn_goods_nextgoods")
        button.setImage(icon, for: .normal)
        button.tintColor = .primary400
        button.setTitle("다음상품 ", for: .normal)
        button.setTitleColor(.primary400, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = MarketKurlyFont.bodySemiBold14.font // bodyMedium14 확인 필요
        
        return button
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
    
    private func setStyle() {
        self.backgroundColor = .white
        
        tableView.do{
            $0.register(RelatedGoodsCell.self,
                        forCellReuseIdentifier: RelatedGoodsCell.identifier)
            $0.rowHeight = 48
            $0.separatorStyle = .none
            $0.dataSource = self
        }
    }
    
    private func setUI() {
        addSubviews(otherCustomersViewedLabel, nextGoodsButton, tableView)
    }
    
    private func setLayout() {
        otherCustomersViewedLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        nextGoodsButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-13)
            $0.centerY.equalTo(otherCustomersViewedLabel)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(otherCustomersViewedLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-21)
            $0.height.equalTo(240)
        }
    }
}

extension RelatedGoods: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RelatedGoodsCell.identifier,
            for: indexPath
        ) as? RelatedGoodsCell else { return UITableViewCell() }
        cell.configure(goods: goodsList[indexPath.row])
        
        return cell
    }
}
