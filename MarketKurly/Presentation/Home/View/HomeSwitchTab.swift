//
//  HomeSwitchTab.swift
//  MarketKurly
//
//  Created by 최지석 on 11/23/24.
//

import UIKit

final class HomeSwitchTab: UIControl {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .primary500
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = false
    }
    
    private let switchTabView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 14
        $0.isUserInteractionEnabled = false
    }
    
    private let marketKurlyTabButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "마켓컬리",
                                                                        color: .primary600,
                                                                        font: MarketKurlyFont.captionSemiBold12.font,
                                                                        textAlignment: .center))
        config.baseBackgroundColor = .clear
        $0.configuration = config
    }
    
    private let beautyKurlyTabButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(.makeAttributedString(text: "뷰티컬리",
                                                                        color: .white,
                                                                        font: MarketKurlyFont.captionMedium12.font,
                                                                        textAlignment: .center))
        config.baseBackgroundColor = .clear
        $0.configuration = config
    }
    
    // 현재 선택된 Tab의 인덱스 (0 또는 1)
    public var selectedIndex: Int = 0 {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubviews(
            containerView.addSubviews(
                switchTabView,
                marketKurlyTabButton,
                beautyKurlyTabButton
            )
        )
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(135)
            $0.height.equalTo(28)
            $0.edges.equalToSuperview()
        }
        
        marketKurlyTabButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(67)
        }
        
        beautyKurlyTabButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo(67)
        }
        
        switchTabView.snp.makeConstraints {
            $0.edges.equalTo(marketKurlyTabButton.snp.edges)
        }
    }
    
    
    private func bindActions() {
        // '마켓컬리' 탭 터치 이벤트 바인딩
        marketKurlyTabButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            if HomeSwitchTabOption(index: selectedIndex) == .beautyKurly {
                selectedIndex = HomeSwitchTabOption.marketKurly.rawValue
                updateTabUI(with: selectedIndex, animated: true)
            }
        }, for: .touchUpInside)
        
        // '뷰티컬리' 탭 터치 이벤트 바인딩
        beautyKurlyTabButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            if HomeSwitchTabOption(index: selectedIndex) == .marketKurly {
                selectedIndex = HomeSwitchTabOption.beautyKurly.rawValue
                updateTabUI(with: selectedIndex, animated: true)
            }
        }, for: .touchUpInside)
    }

    
    private func updateTabUI(with selectedIndex:Int, animated: Bool) {
        // 현재 선택된 탭
        let selectedTabOption = HomeSwitchTabOption(index: selectedIndex)
        
        let tabUpdateWork = { [weak self] in
            guard let self else { return }
            self.updateTabPosition(with: selectedTabOption)        // (1) 탭뷰 위치 업데이트
            self.updateTabFontsAndColors(with: selectedTabOption)  // (2) 탭 버튼 내 타이틀 컬러, 폰트 업데이트
            self.updateBackgroundColors(with: selectedTabOption)   // (3) 탭뷰, 컨테이너 뷰 배경색 업데이트
            self.layoutIfNeeded()
        }
        
        // 애니메이션 적용에 따라 분기
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.curveEaseInOut],
                           animations: tabUpdateWork)
        } else {
            tabUpdateWork()
        }
    }
    
    
    private func updateTabPosition(with selectedTab: HomeSwitchTabOption) {
        switchTabView.snp.remakeConstraints {
            if selectedTab == .marketKurly {
                $0.edges.equalTo(marketKurlyTabButton.snp.edges)
            } else {
                $0.edges.equalTo(beautyKurlyTabButton.snp.edges)
            }
        }
    }
    

    private func updateTabFontsAndColors(with selectedTab: HomeSwitchTabOption) {
        updateButtonConfiguration(
            button: marketKurlyTabButton,
            text: "마켓컬리",
            font: selectedTab == .marketKurly ? .captionSemiBold12 : .captionMedium12,
            color: selectedTab == .marketKurly ? .primary600 : .gray6
        )
        
        updateButtonConfiguration(
            button: beautyKurlyTabButton,
            text: "뷰티컬리",
            font: selectedTab == .beautyKurly ? .captionMedium12 : .captionSemiBold12,
            color: .white
        )
    }
    
    
    private func updateButtonConfiguration(button: UIButton, text: String, font: MarketKurlyFont, color: UIColor) {
        var buttonConfig = button.configuration
        buttonConfig?.attributedTitle = AttributedString(
            .makeAttributedString(text: text, color: color, font: font.font)
        )
        button.configuration = buttonConfig
    }
    
    
    private func updateBackgroundColors(with selectedTab: HomeSwitchTabOption) {
        containerView.backgroundColor = selectedTab == .marketKurly ? .primary500 : .gray2
        switchTabView.backgroundColor = selectedTab == .marketKurly ? .white : .primary600
    }
}
