//
//  RatingStarView.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/22/24.
//

import UIKit

import SnapKit
import Then

class RatingStarView: UIView {
    private let starStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    private let maxStars = 5

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(starStackView)
    }

    private func setLayout() {
        starStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateRating(_ rating: Int) {
        resetStars()

        for index in 0..<maxStars {
            let starImageView = createStarImageView(isFilled: index < rating)
            starStackView.addArrangedSubview(starImageView)
        }
    }

    private func resetStars() {
        starStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func createStarImageView(isFilled: Bool) -> UIImageView {
        return UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: isFilled ? "ic_star_filled" : "ic_star_unfilled")
        }
    }
}
