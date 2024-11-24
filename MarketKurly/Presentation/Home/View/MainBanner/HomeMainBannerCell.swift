//
//  HomeMainBannerCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import Then
import SnapKit

final class HomeMainBannerCell: UICollectionViewCell {
    
    static let identifier = "HomeMainBannerCell"
    
    private let bannerView = HomeMainBannerView().then {
        $0.autoScrollDuration = 4.0
        $0.isAutoScrollEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setUI(with items: [HomeMainBannerItem]) {
        let imageUrls = items.compactMap { $0.imageUrl }
        bannerView.setImages(imageUrls)
        bannerView.startAutoScroll()
    }
}
