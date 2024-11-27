//
//  UITableView+.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/27/24.
//

import UIKit

extension UITableViewCell {
    static var identifier : String {
        return String(describing: self)
    }
    
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
