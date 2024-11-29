//
//  TempViewController.swift
//  MarketKurly
//
//  Created by 이세민 on 11/21/24.
//

import UIKit

import SnapKit

class TempViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .kurlyWhite
        
        let button = UIButton(type: .system)
        button.setTitle("Go to Detail", for: .normal)
        button.setTitleColor(.kurlyWhite, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func didTapButton() {
        let segmentedPageVC = SegmentedPageViewController()
        self.navigationController?.pushViewController(segmentedPageVC, animated: true)
        self.navigationItem.backButtonTitle = ""
    }
}

