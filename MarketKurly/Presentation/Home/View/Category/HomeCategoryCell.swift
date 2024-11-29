//
//  HomeCategoryCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import Then
import SnapKit

final class HomeCategoryCell: UICollectionViewCell {
    
    private let containerView = UIView()
    
    private let imageContainerView = UIView().then {
        $0.backgroundColor = .coolGray1
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    private func makeUI() {
        contentView.addSubviews(
            containerView.addSubviews(
                imageContainerView.addSubviews(
                    imageView
                ),
                titleLabel
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(65)
        }
        
        imageContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(42)
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    public func setUI(iconImage: String?, title: String?) {
        
        if let iconImage {
            imageView.image = UIImage(named: iconImage)
        }
        
        if let title {
            titleLabel.attributedText = .makeAttributedString(text: title,
                                                              color: .coolGray5,
                                                              font: MarketKurlyFont.captionMedium12.font.withLetterSpacing(-2),
                                                              textAlignment: .center)
        }
    }
    
    
    private func clearUI() {
        imageView.image = nil
        titleLabel.attributedText = nil
    }
}


