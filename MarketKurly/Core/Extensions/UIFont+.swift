//
//  UIFont+.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/18/24.
//

import UIKit

extension UIFont {
    
    func withLineHeight(_ lineHeight: CGFloat) -> UIFont {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        return applyingAttributes([.paragraphStyle: paragraphStyle])
    }
    
    func withLetterSpacing(_ letterSpacing: CGFloat) -> UIFont {
        return applyingAttributes([.kern: letterSpacing])
    }
    
    private func applyingAttributes(_ attributes: [NSAttributedString.Key: Any]) -> UIFont {
        let fontAttributes = [NSAttributedString.Key.font: self] as [NSAttributedString.Key: Any]
        let combinedAttributes = fontAttributes.merging(attributes) { current, _ in current }
        
        let attributedString = NSAttributedString(string: "Sample", attributes: combinedAttributes)
        
        return UIFont(descriptor: self.fontDescriptor, size: pointSize)
    }
}

