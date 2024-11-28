//
//  WishListCategoryCollectionViewCell.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/28/24.
//

import UIKit

import SnapKit
import Then

class WishListCategoryCollectionViewCell: UICollectionViewCell {
    private let categoryContainer = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray3.cgColor
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    private let categoryLabel = UILabel().then {
        $0.font = MarketKurlyFont.captionMedium12.font
        $0.textColor = .gray6
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(categoryContainer)
        categoryContainer.addSubview(categoryLabel)
    }
    
    private func setLayout() {
        categoryContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(title: String, isSelected: Bool) {
        categoryLabel.text = title
        switch isSelected {
        case true:
            categoryContainer.do {
                $0.backgroundColor = .primary400
                $0.layer.borderWidth = 0
            }
            categoryLabel.do {
                $0.textColor = .white
            }
        case false:
            categoryContainer.do {
                $0.backgroundColor = .white
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.gray3.cgColor
                $0.layer.cornerRadius = 4
                $0.clipsToBounds = true
            }
            categoryLabel.do {
                $0.textColor = .gray6
            }
        }
    }
    
    static func calculateCellSize(for title: String) -> CGSize {
            let label = UILabel()
            label.font = MarketKurlyFont.captionMedium12.font
            label.text = title
            label.sizeToFit()
            
            let labelWidth = label.frame.width + 16
            let labelHeight = label.frame.height + 12
            
            return CGSize(width: labelWidth, height: labelHeight)
        }
}
