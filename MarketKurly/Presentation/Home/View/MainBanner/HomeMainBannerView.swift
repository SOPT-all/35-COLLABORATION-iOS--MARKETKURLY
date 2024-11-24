//
//  HomeMainBannerView.swift
//  MarketKurly
//
//  Created by 최지석 on 11/24/24.
//

import UIKit
import SnapKit
import Then

class HomeMainBannerView: UIView {
    
    private let containerView = UIView()
    
    // 무한 스크롤 배너 컬렉션 뷰
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(HomeMainBannerCell.self, forCellWithReuseIdentifier: HomeMainBannerCell.identifier)
        }
    }()
    
    private let pageControl = HomeMainBannerPageControl()
    
    
    // 배너 이미지
    private var bannerImages: [String] = [] {
        didSet {
            updateBannerItems()
        }
    }
    
    // 실제 컬렉션 뷰에서 사용되는 배너 아이템
    private var bannerItems: [String] = []
    
    // 페이지 스크롤 타이머
    private var timer: Timer?
    
    
    var isAutoScrollEnabled: Bool = false  // 자동 스크롤 활성화 여부
    var autoScrollDuration: Double = 5.0   // 자동 스크롤 지속 시간
    
    
    init() {
        super.init(frame: .zero)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUI() {
        addSubviews(
            containerView.addSubviews(
                bannerCollectionView,
                pageControl
            )
        )
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    
    private func updateBannerItems() {
        bannerItems.removeAll()
        
        if bannerImages.count > 1 {
            if let lastImage = bannerImages.last {
                bannerItems.append(lastImage)
            }
            
            bannerItems.append(contentsOf: bannerImages)  // 1번 인덱스부터 셀 시작
            
            if let firstImage = bannerImages.first {
                bannerItems.append(firstImage)
            }
            
            // 첫 번째 페이지로 스크롤
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.bannerCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0),
                                                       at: .centeredHorizontally,
                                                       animated: false)
            }
        } else {
            bannerItems.append(contentsOf: bannerImages)
        }
        
        bannerCollectionView.reloadData()
        
        // 최초 페이지 컨트롤 '1'로 세팅
        pageControl.setUI(currentPage: 1, totalPageCount: bannerImages.count)
    }
    
    
    public func setImages(_ bannerImages: [String]) {
        self.bannerImages = bannerImages
    }
    
    
    public func startAutoScroll() {
        stopAutoScroll()
        if bannerImages.count > 1 {
            timer = Timer.scheduledTimer(timeInterval: autoScrollDuration, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        }
    }
    
    
    public func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    
    @objc private func scrollToNextPage() {
        let visibleIndexPath = bannerCollectionView.indexPathsForVisibleItems.first
        guard let currentIndex = visibleIndexPath?.item else { return }
        
        let nextIndex = currentIndex + 1
        bannerCollectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0),
                                          at: .centeredHorizontally,
                                          animated: true)
    }
}


extension HomeMainBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainBannerCell.identifier, for: indexPath) as? HomeMainBannerCell else {
            return UICollectionViewCell()
        }
        
        cell.setUI(with: bannerItems[indexPath.item])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let pageWidth = scrollView.frame.width
        
        // 현재 페이지 계산
        let index = Int(round(contentOffsetX / pageWidth))
        
        // 실제 페이지 계산 (앞뒤 추가된 이미지 고려)
        let currentPage = max(1, min(bannerImages.count, index))
        let totalCountPage = bannerImages.count
        
        // 페이지 컨트롤 라벨 업데이트
        pageControl.setUI(currentPage: currentPage, totalPageCount: totalCountPage)
        
        // 배너 이미지 무한 스크롤
        if contentOffsetX <= 0 {
            scrollView.contentOffset.x = pageWidth * CGFloat(bannerImages.count)
        } else if contentOffsetX >= pageWidth * CGFloat(bannerItems.count - 1) {
            scrollView.contentOffset.x = pageWidth
        }
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 드래그 시작 시 자동 스크롤 비활성화
        stopAutoScroll()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 드래그 종료 시 자동 스크롤 활성화
        if isAutoScrollEnabled {
            startAutoScroll()
        }
    }
}


