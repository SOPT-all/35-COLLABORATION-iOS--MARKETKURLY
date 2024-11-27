//
//  UnderlineSegmentedControl.swift
//  MarketKurly
//
//  Created by 이세민 on 11/23/24.
//

import UIKit

class UnderlineSegmentedControl: UISegmentedControl {
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary600
        view.frame.size.height = 2.0
        return view
    }()
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        setUI()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        setTitleTextAttributes([
            .foregroundColor: UIColor.gray6,
            .font: MarketKurlyFont.bodySemiBold14.font
        ], for: .normal)
        setTitleTextAttributes([
            .foregroundColor: UIColor.primary600,
            .font: MarketKurlyFont.bodySemiBold14.font
        ], for: .selected)
    }
    
    private func setUI() {
        addSubview(underLineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let title = titleForSegment(at: selectedSegmentIndex) else { return }
        
        let textWidth = (title as NSString).size(withAttributes: titleTextAttributes(for: .selected)).width
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let underlineX = (CGFloat(selectedSegmentIndex) * segmentWidth) + (segmentWidth - textWidth) / 2
        
        UIView.animate(withDuration: 0.2) {
            self.underLineView.frame = CGRect(x: underlineX,
                                              y: self.bounds.height - 2,
                                              width: textWidth,
                                              height: 2)
        }
    }
}
