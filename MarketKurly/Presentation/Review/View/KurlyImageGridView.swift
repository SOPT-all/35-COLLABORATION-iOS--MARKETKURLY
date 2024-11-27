//
//  KurlyImageGridView.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/22/24.
//

import UIKit

import SnapKit
import Kingfisher
import Then

class KurlyImageGridView: UIView {
    private var imageUrls: [String] = []
    private let maxImagesPerRow = 4
    private let maxVisibleImages = 4
    private let imageSize: CGFloat = (UIScreen.main.bounds.width - 38) / 4

    private let imageStackView = UIStackView().then {
        $0.spacing = 2
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private var imageViews: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayout()
        setStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(imageStackView)
    }

    private func setLayout() {
        imageStackView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
    }

    private func setStyle() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        clipsToBounds = true
    }

    func updateImages(with urls: [String]) {
        imageUrls = urls
        resetImageViews()

        let visibleUrls = Array(imageUrls.prefix(maxVisibleImages))
        for (index, urlString) in visibleUrls.enumerated() {
            guard let url = URL(string: urlString) else { continue }

            let imageView = createImageView(with: url)
            imageStackView.addArrangedSubview(imageView)
            imageViews.append(imageView)

            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(imageSize)
            }

            if index == maxVisibleImages - 1, imageUrls.count > maxVisibleImages {
                addOverlay(to: imageView, count: imageUrls.count - maxVisibleImages)
            }
        }
    }

    private func resetImageViews() {
        imageViews.forEach { $0.removeFromSuperview() }
        imageViews.removeAll()
    }

    private func createImageView(with url: URL) -> UIImageView {
        return UIImageView().then {
            $0.kf.setImage(with: url)
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
    }

    private func addOverlay(to imageView: UIImageView, count: Int) {
        let overlayView = UIView().then {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        imageView.addSubview(overlayView)

        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let label = UILabel().then {
            $0.text = "+ 더보기"
            $0.textColor = .white
            $0.font = MarketKurlyFont.captionSemiBold12.font
            $0.textAlignment = .center
        }
        overlayView.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
