//
//  HomeScrollTabCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import SnapKit

final class HomeScrollTabCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    
    private func makeUI() {
        addSubviews(
            titleLabel
        )
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    func setUI(title: String, isSelected: Bool) {
        titleLabel.attributedText = .makeAttributedString(text: title,
                                                          color: isSelected ? .primary600 : .gray6,
                                                          font: MarketKurlyFont.bodySemiBold14.font,
                                                          textAlignment: .center)
    }
    
    
    private func clearUI() {
        titleLabel.attributedText = nil
    }
}

