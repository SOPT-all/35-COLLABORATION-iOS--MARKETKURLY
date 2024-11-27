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
    private let reviewTableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setLayout()
        setStyle()
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
        default: return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewTitleSectionCell.identifier, for: indexPath) as? ReviewTableViewTitleSectionCell else { return UITableViewCell() }
            cell.configure(imageUrls: ["https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU","https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU","https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU","https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU","https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU","https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU"])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default: guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
            cell.configure(data: ReviewData(isAdvertisement: true, name: "이이이", discription: "이이이이", imageUrls: ["https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU","https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU"], rating: 4.5, review: "이이이", date: "2024-01-01"))
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ReviewTableViewHeader().then{
            $0.configure(count: 10000, selectedSort: "최신순")
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
