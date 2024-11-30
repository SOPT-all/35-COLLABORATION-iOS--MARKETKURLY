//
//  ReviewViewController.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/22/24.
//

import UIKit

import SnapKit
import Then

class ReviewViewController: UIViewController {
    
    private var productId: Int
    private var reviewData: ResponseReviewDTO?
    
    private let reviewTableView = UITableView(frame: .zero, style: .grouped)
    
    init(productId: Int) {
        self.productId = productId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setLayout()
        setStyle()
        fetchReview(productId: productId)
    }
    
    private func addSubviews() {
        view.addSubview(reviewTableView)
    }
    
    private func setLayout() {
        reviewTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setStyle() {
        view.backgroundColor = .white
        
        reviewTableView.do {
            $0.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
            $0.register(ReviewTableViewTitleSectionCell.self, forCellReuseIdentifier: ReviewTableViewTitleSectionCell.identifier)
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
        }
        
        reviewTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.sectionHeaderHeight = UITableView.automaticDimension
        reviewTableView.estimatedRowHeight = 100
        reviewTableView.sectionFooterHeight = 7
        
        if #available(iOS 15.0, *) {
            reviewTableView.sectionHeaderTopPadding = 0
        }
        
        reviewTableView.tableHeaderView = UIView()
    }
}

extension ReviewViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return reviewData?.reviews.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewTitleSectionCell.identifier, for: indexPath) as? ReviewTableViewTitleSectionCell else { return UITableViewCell() }
            cell.configure(imageUrls: [reviewData?.reviews.first?.image1 ?? "", reviewData?.reviews.first?.image2 ?? "", reviewData?.reviews.first?.image3 ?? ""])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default: guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
            guard let reviewData = reviewData else { return UITableViewCell() }
            cell.configure(data: reviewData.reviews[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ReviewTableViewHeader().then{
            $0.configure(count: reviewData?.reviews.count ?? 0, selectedSort: "최신순")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1: return UITableView.automaticDimension
        default: return .leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 7
    }
}

extension ReviewViewController {
    private func fetchReview(productId: Int) {
        ReviewApi.shared.getReviews(productId: productId) { [weak self] result in
            switch result {
            case .success(let reviewDto):
                self?.reviewData = reviewDto
                print("리뷰 dto \(reviewDto)")
                self?.reviewTableView.reloadData()
            case .failure(let error):
                print("에러 \(error)")
            }
        }
    }
}
