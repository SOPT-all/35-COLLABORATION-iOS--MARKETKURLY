//
//  HomeScrollTab.swift
//  MarketKurly
//
//  Created by 최지석 on 11/23/24.
//

import UIKit
import SnapKit
import Then

final class HomeScrollTab: UIControl {
    
    private var tabItems: [String] = []    // 탭 아이템
    
    public var selectedIndex: Int = 0 {   // 선택된 탭 인덱스
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    private let containerView = UIView()
    
    // SwitchTab 컬렉션 뷰
    private lazy var tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 22
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeScrollTabCell.self, forCellWithReuseIdentifier: HomeScrollTabCell.identifier)
        
        return collectionView
    }()
    
    // SwitchTab 하단 슬라이더 뷰
    private let bottomSlider = UIView().then {
        $0.backgroundColor = .primary600
    }

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubviews(
            containerView.addSubviews(
                tabCollectionView,
                bottomSlider
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tabCollectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-2)
            $0.height.equalTo(42)
        }
        
        bottomSlider.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    /// 탭 아이템을 갱신하는 메서드
    /// - Parameters:
    ///   - items: 새로운 탭 아이템 (배열)
    ///   - animated: 탭 전환 및 하단 슬라이더 이동 애니메이션 적용 여부
    /// - Discussion:
    ///   해당 메서드는 새로운 탭 아이템을 설정하고, `selectedIndex`를 첫 번째 탭(인덱스 0)으로 초기화하는 메서드이다.
    ///   컬렉션 뷰를 새 데이터로 다시 로드하며, 하단 슬라이더의 위치를 첫 번째 탭에 맞게 업데이트한다.
    ///   `animated` 값이 `true`로 설정된 경우, 슬라이더 이동과 탭 스크롤이 애니메이션으로 처리된다.
    public func setTab(items: [String], animated: Bool) {
        // 탭 아이템 갱신
        tabItems = items
        tabCollectionView.reloadData()
        
        selectedIndex = 0 // 탭 변경 시, 첫 번째 탭 고정 선택되도록 설정
        tabCollectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0),
                                       at: .centeredHorizontally,
                                       animated: animated)
        
        updateBottomSliderPosition(index: selectedIndex, animated: animated)
    }
    
    
    /// 특정 탭을 선택(활성화)하는 메서드
    /// - Parameters:
    ///   - index: 선택하려는 탭의 인덱스 (0부터 시작하는 Int 값)
    ///   - animated: 탭 전환 및 하단 슬라이더 이동 애니메이션 적용 여부
    /// - Discussion:
    ///   해당 메서드는 인자로 전달한 인덱스에 부합하는 탭을 선택(활성화)하는 메서드이다.
    ///   `index`가 유효한 경우 `selectedIndex`를 변경하고, 컬렉션 뷰를 새로고침하여 선택된 탭의 UI를 업데이트한다.
    ///   `animated` 값이 `true`로 설정된 경우, 슬라이더 이동과 선택된 탭으로의 스크롤이 애니메이션으로 처리된다.
    public func setSelectedIndex(to index: Int, animated: Bool) {
        guard index >= 0, index < tabItems.count else {
            return
        }
        
        // 선택된 인덱스 변경
        selectedIndex = index
        
        // 컬렉션 뷰 업데이트 및 선택된 탭 변경
        tabCollectionView.reloadData()
        tabCollectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0),
                                       at: .centeredHorizontally,
                                       animated: animated)
        
        // 하단 슬라이더 이동
        updateBottomSliderPosition(index: selectedIndex, animated: animated)
    }
    
    
    //
    private func updateBottomSliderPosition(index: Int, animated: Bool) {

        tabCollectionView.layoutIfNeeded()
        
        guard let cell = tabCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? HomeScrollTabCell else {
            return
        }

        bottomSlider.snp.remakeConstraints {
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(cell.snp.width)
            $0.centerX.equalTo(cell.snp.centerX)
        }

        if animated {
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                guard let self else { return }
                self.layoutIfNeeded()
            })
        } else {
            layoutIfNeeded()
        }
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension HomeScrollTab: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeScrollTabCell.identifier, for: indexPath) as? HomeScrollTabCell else {
            return UICollectionViewCell()
        }
        
        let isSelected = indexPath.item == selectedIndex
        
        cell.setUI(title: tabItems[indexPath.item], isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        updateBottomSliderPosition(index: selectedIndex, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let titleText = tabItems[indexPath.item]
        
        let attributedTitle = NSAttributedString.makeAttributedString(text: titleText,
                                                                      color: .gray6,
                                                                      font: MarketKurlyFont.bodySemiBold14.font,
                                                                      textAlignment: .center)
        
        // 셀 너비는 text 너비 + 좌우 2px로 설정
        let cellWidth: CGFloat = attributedTitle.size().width + 4
        let cellHeight: CGFloat = 42
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
