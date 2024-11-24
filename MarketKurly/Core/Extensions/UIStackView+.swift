//
//  UIStackView+.swift
//  MarketKurly
//
//  Created by 최지석 on 11/23/24.
//

import UIKit

extension UIStackView {
    @discardableResult func addArrangedSubviews(_ views: UIView...) -> UIStackView {
        views.forEach { [weak self] subview in
            guard let self else { return }
            self.addArrangedSubview(subview)
        }
        return self
    }
}
