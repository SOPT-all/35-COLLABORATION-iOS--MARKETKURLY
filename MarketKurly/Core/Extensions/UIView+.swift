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
    
    func applyShadow(offset: CGSize = CGSize(width: 0, height: 2),
                     opacity: Float = 0.16,
                     radius: CGFloat = 18.0,
                     color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
