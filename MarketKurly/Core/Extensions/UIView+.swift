//
//  UIView+.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/18/24.
//

import UIKit

extension UIView {
    @discardableResult func addSubviews(_ views: UIView...) -> UIView {
        views.forEach { [weak self] subview in
            guard let self else { return }
            self.addSubview(subview)
        }
        return self
    }
}
