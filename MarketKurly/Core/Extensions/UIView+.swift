//
//  UIView+.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/18/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
