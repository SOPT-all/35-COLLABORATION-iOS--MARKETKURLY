//
//  WishListViewController.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/28/24.
//

import UIKit

class WishListViewController: UIViewController {
    private let backButtonImageView = UIImageView(image: .icBackButton)
    
    private var wishListData : ResponseWishListDTO?
    
    private let titleLabel = UILabel().then {
        $0.text = "찜한 상품"
        $0.font = MarketKurlyFont.bodyBold16.font
        $0.textColor = .gray7
    }
    
    private let notificationImageView = UIImageView(image: .icNotification)
    
    private let cartImageView = UIImageView(image: .icCart40)
    
    private let wishListTableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setLayout()
        setStyle()
        fetchWishList(memberId: 6)
    }
    
    private func addSubviews() {
        view.addSubviews(backButtonImageView, titleLabel, notificationImageView, cartImageView, wishListTableView)
    }
    
    private func setLayout() {
        backButtonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(63)
            $0.leading.equalToSuperview().offset(4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButtonImageView)
        }
        
        notificationImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(cartImageView.snp.leading).offset(-5)
        }
        
        cartImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        wishListTableView.snp.makeConstraints {
            $0.top.equalTo(cartImageView.snp.bottom).offset(19)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        wishListTableView.do {
            $0.register(WishListTableViewCell.self, forCellReuseIdentifier: WishListTableViewCell.identifier)
            $0.register(WishListCategoryTableViewCell.self, forCellReuseIdentifier: WishListCategoryTableViewCell.identifier)
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.bounces = false
        }
        
        wishListTableView.rowHeight = UITableView.automaticDimension
        wishListTableView.sectionHeaderHeight = 0
        wishListTableView.estimatedRowHeight = 100
        wishListTableView.sectionFooterHeight = 0
        wishListTableView.backgroundColor = .clear
        
        if #available(iOS 15.0, *) {
            wishListTableView.sectionHeaderTopPadding = 0
        }
        
        wishListTableView.tableHeaderView = UIView()
    }
}

extension WishListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return wishListData?.products.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: guard let cell = wishListTableView.dequeueReusableCell(withIdentifier: WishListCategoryTableViewCell.identifier, for: indexPath) as? WishListCategoryTableViewCell else { return UITableViewCell() }
            guard let count = wishListData?.products.count else { return UITableViewCell() }
            cell.configure(with: ["전체 \(count)개", "유제품", "간편식.밀키트.샐러드", "과일.견과.쌀", "간식"])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default: guard let cell = wishListTableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier, for: indexPath) as? WishListTableViewCell else { return UITableViewCell() }
            guard let data = wishListData else { return UITableViewCell() }
            cell.configure(data: data.products[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1: return UITableView.automaticDimension
        default: return .leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.width)
        } else {
            cell.separatorInset = .zero
        }
    }
}

extension WishListViewController {
    private func fetchWishList(memberId: Int) {
        WishListApi.shared.getWishList(memberId: memberId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.wishListData = data
                self?.wishListTableView.reloadData()
            case .failure(let error):
                print("에러 \(error)")
            }
        }
    }
}
