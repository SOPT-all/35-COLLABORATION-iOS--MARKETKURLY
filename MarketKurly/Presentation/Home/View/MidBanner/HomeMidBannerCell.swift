//
//  MidBanner.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import SnapKit
import Then

final class HomeMidBannerCell: UICollectionViewCell {
    
    static let identifier = "HomeMidBannerCell"

    private let bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        contentView.addSubview(
            bannerImageView
        )
        
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
    public func setUI(with item: HomeMidBannerItem) {
        if let imageUrl = item.imageUrl {
            bannerImageView.image = UIImage(named: imageUrl) // 로컬 이미지 설정
        }
    }
    
    
    private func clearUI() {
        bannerImageView.image = nil
    }
}
