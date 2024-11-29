//
//  HomeMainBannerCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import Then
import SnapKit

class HomeMainBannerInnerCell: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(
            imageView
        )
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clearUI()
    }
    
    
    public func setUI(with bannerImage: String) {
        imageView.image = UIImage(named: bannerImage)
    }
    
 
    private func clearUI() {
        imageView.image = nil
    }
}
