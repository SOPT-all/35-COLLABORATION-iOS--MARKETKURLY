//
//  HomeViewController.swift
//  MarketKurly
//
//  Created by 최지석 on 11/22/24.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    private let topNavigation = HomeTopNavigation()
    
    private let scrollTab = HomeScrollTab()
    
    private lazy var contentsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout()).then {
        $0.backgroundColor = .white
        $0.delegate = self
        $0.register(HomeMainBannerCell.self,
                    forCellWithReuseIdentifier: HomeMainBannerCell.identifier)
        $0.register(HomeCategoryCell.self,
                    forCellWithReuseIdentifier: HomeCategoryCell.identifier)
        $0.register(HomeWishListCell.self,
                    forCellWithReuseIdentifier: HomeWishListCell.identifier)
        $0.register(HomeWishListHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: HomeWishListHeaderView.identifier)
        $0.register(HomeMidBannerCell.self,
                    forCellWithReuseIdentifier: HomeMidBannerCell.identifier)
        $0.register(HomeRankingListCell.self,
                    forCellWithReuseIdentifier: HomeRankingListCell.identifier)
        $0.register(HomeRankingHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: HomeRankingHeaderView.identifier)
        $0.register(HomeRankingFooterView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: HomeRankingFooterView.identifier)
        $0.register(HomeRecommendListCell.self,
                    forCellWithReuseIdentifier: HomeRecommendListCell.identifier)
        $0.register(HomeRecommendListHeaderView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: HomeRecommendListHeaderView.identifier)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, AnyHashable>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        makeUI()
        setUI()
        bindActions()
        
        fetchHomeData()
    }

    
    private func makeUI() {
        view.backgroundColor = .white
        
        view.addSubviews(
            topNavigation,
            scrollTab,
            contentsCollectionView
        )
        
        topNavigation.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(88)  // FIXME: top-safe-area 고려 필요
        }
        
        scrollTab.snp.makeConstraints {
            $0.top.equalTo(topNavigation.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentsCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrollTab.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-90)
        }
    }
    
    
    private func bindActions() {
        scrollTab.addTarget(self, action: #selector(scrollTabValueDidChange(_:)), for: .valueChanged)
    }
    
    
                            @objc private func scrollTabValueDidChange(_ sender: HomeScrollTab) {
        print("Scroll Tab index changed: \(sender.selectedIndex)")
    }
    
    
    private func setUI() {
        // 스크롤 탭 세팅
        scrollTab.setTab(items: ["컬리추천", "베스트", "신상품", "알뜰쇼핑", "특가/혜택"],
                         animated: false)
    }
    
    
    // 컬렉션 뷰 DataSource 세팅
    private func setupDataSource() {
        // 셀 세팅
        dataSource = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>(collectionView: contentsCollectionView) { collectionView, indexPath, item in
            switch HomeSection(rawValue: indexPath.section) {
            // 메인 배너
            case .mainBanner:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeMainBannerCell.identifier, for: indexPath
                ) as? HomeMainBannerCell else {
                    return UICollectionViewCell()
                }
                if let bannerSection = item as? HomeMainBannerSection {
                    cell.setUI(with: bannerSection.mainBannerData ?? [])
                }
                return cell
            // 카테고리
            case .category:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeCategoryCell.identifier, for: indexPath
                ) as? HomeCategoryCell else {
                    return UICollectionViewCell()
                }
                if let categoryItem = item as? HomeCategoryItem {
                    cell.setUI(iconImage: categoryItem.imageUrl, title: categoryItem.title)
                }
                return cell
            // 위시 리스트
            case .wishList:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeWishListCell.identifier, for: indexPath
                ) as? HomeWishListCell else {
                    return UICollectionViewCell()
                }
                if let wishListItem = item as? HomeWishListItem,
                   let productId = wishListItem.id {
                    cell.setUI(with: wishListItem)
                    // 탭 터치 이벤트 바인딩
                    cell.onCellTap = { [weak self] in
                        guard let self else { return }
                        let detailViewController = SegmentedPageViewController(productId: productId)
                        navigationController?.pushViewController(detailViewController, animated: true)
                        navigationItem.backButtonTitle = ""
                    }
                }
                return cell
            // 중간 광고 배너
            case .midBanner:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeMidBannerCell.identifier, for: indexPath
                ) as? HomeMidBannerCell else {
                    return UICollectionViewCell()
                }
                if let midBannerItem = item as? HomeMidBannerItem {
                    cell.setUI(with: midBannerItem)
                }
                return cell
            // 랭킹 리스트
            case .rankingList:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeRankingListCell.identifier, for: indexPath
                ) as? HomeRankingListCell else {
                    return UICollectionViewCell()
                }
                if let rankingListItem = item as? HomeRankingListItem {
                    cell.setUI(with: rankingListItem, cellIndex: indexPath.row + 1)
                }
                return cell
            // 추천 리스트
            case .recommendList:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HomeRecommendListCell.identifier, for: indexPath
                ) as? HomeRecommendListCell else {
                    return UICollectionViewCell()
                }
                if let recommendListItem = item as? HomeRecommendListItem {
                    cell.setUI(with: recommendListItem)
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        }

        
        // 헤더, 푸터 세팅
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let section = HomeSection(rawValue: indexPath.section) else { return nil}
            
            switch section {
                // 위시 리스트
            case .wishList:
                // 헤더
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HomeWishListHeaderView.identifier,
                    for: indexPath
                ) as? HomeWishListHeaderView
                return header
                // 랭킹 리스트
            case .rankingList:
                switch kind {
                    // 헤더
                case UICollectionView.elementKindSectionHeader:
                    let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: HomeRankingHeaderView.identifier,
                        for: indexPath
                    ) as? HomeRankingHeaderView
                    return header
                    // 푸터
                case UICollectionView.elementKindSectionFooter:
                    let footer = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: HomeRankingFooterView.identifier,
                        for: indexPath
                    ) as? HomeRankingFooterView
                    return footer
                default:
                    return nil
                }
                // 추천 리스트
            case .recommendList:
                // 헤더
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HomeRecommendListHeaderView.identifier,
                    for: indexPath
                ) as? HomeRecommendListHeaderView
                return header
            default:
                return nil
            }
        }
    }

    
    
    // 컬렉션 뷰 레이아웃 세팅
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self, let section = HomeSection(rawValue: sectionIndex) else { return nil }
            switch section {
            case .mainBanner:
                return self.createMainBannerLayout()
            case .category:
                return self.createCategoryLayout()
            case .wishList:
                return self.createWishListLayout()
            case .midBanner:
                return self.createMidBannerLayout()
            case .rankingList:
                return self.createRankingSection()
            case .recommendList:
                return self.createRecommendListLayout()
            }
        }
        
        layout.register(HomeRankingListGradientBackgroundView.self,
                        forDecorationViewOfKind: HomeRankingListGradientBackgroundView.identifier)
        
        return layout
    }
    
    
    // 탑 배너 레이아웃 세팅
    private func createMainBannerLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(278))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    
    // 카테고리 레이아웃 세팅
    private func createCategoryLayout() -> NSCollectionLayoutSection {
        // 아이템 크기: 65x65
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(65))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(137))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(7)  // 두 행 사이 간격
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous  // 가로 스크롤
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 12, bottom: 13, trailing: 13)
        
        return section
    }
    
    
    // 위시 리스트 레이아웃 세팅
    private func createWishListLayout() -> NSCollectionLayoutSection {
        // 아이템 크기: 145x330
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .absolute(330))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .absolute(330))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 7

        // 헤더 추가
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }


    // 중간 광고 배너 레이아웃 세팅
    private func createMidBannerLayout() -> NSCollectionLayoutSection {
        // 아이템 크기 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // 그룹 크기 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // 섹션 생성
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 28, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    
    // 랭킹 리스트 레이아웃 세팅
    private func createRankingSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(183), heightDimension: .absolute(344))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(183), heightDimension: .absolute(344))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 11

        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(113))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // Footer
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(92))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        // Decoration
        let backgroundView = NSCollectionLayoutDecorationItem.background(elementKind: HomeRankingListGradientBackgroundView.identifier)
        section.decorationItems = [backgroundView]

        // 헤더와 푸터 설정
        section.boundarySupplementaryItems = [header, footer]

        return section
    }

    
    // 추천 리스트 레이아웃 세팅
    private func createRecommendListLayout() -> NSCollectionLayoutSection {
        // 아이템 크기: 145x330
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .absolute(330))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .absolute(330))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 30, trailing: 16)
        section.interGroupSpacing = 7

        // 헤더 추가
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(103))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }
    
    
    // Snapshot 적용
    private func applySnapshot(with data: HomeDto) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>()

        // (1) 메인 배너
        snapshot.appendSections([.mainBanner])
        snapshot.appendItems([MockData.homeBannerSection], toSection: .mainBanner)

        // (2) 카테고리
        if let categoryData = MockData.categorySection.categoryData {
            snapshot.appendSections([.category])
            snapshot.appendItems(categoryData, toSection: .category)
        }

        // (3) 위시 리스트
        if let wishListData = data.mainTopProducts {
            snapshot.appendSections([.wishList])
            snapshot.appendItems(wishListData, toSection: .wishList)
        }

        // (4) 중간 광고 배너
        if let midBannerData = MockData.midBannerSection.midBannerData {
            snapshot.appendSections([.midBanner])
            snapshot.appendItems(midBannerData, toSection: .midBanner)
        }
        
        // (5) 랭킹 리스트
        if let rankingListData = data.mainMiddleProducts {
            snapshot.appendSections([.rankingList])
            snapshot.appendItems(rankingListData, toSection: .rankingList)
        }
        
        if let recommendListData = data.mainBottomData  {
            snapshot.appendSections([.recommendList])
            snapshot.appendItems(recommendListData, toSection: .recommendList)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }


    private func fetchHomeData() {
        // API 호출
        HomeApi.shared.getHomeData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let data else { return }
                self.applySnapshot(with: data)
            case .failure(let error):
                print("Log - \(error.errorMessage)")
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}


#if DEBUG
import SwiftUI
struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        HomeViewController()
    }
}

#Preview {
    HomeViewControllerRepresentable()
}
#endif
