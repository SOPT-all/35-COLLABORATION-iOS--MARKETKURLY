//
//  TabBarController.swift
//  MarketKurly
//
//  Created by 최지석 on 11/22/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    deinit {
        debugPrint("TabBarController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (1) 탭바 아이템 리스트 생성
        let pages: [TabBarPage] = TabBarPage.allCases.sorted(by: { $0.pageIndex() < $1.pageIndex() })
        
        // (2) 탭바별 뷰 컨트롤러 생성 및 연결
        let viewControllers: [UINavigationController] = pages.map {
            createTabNavigationController(for: $0)
        }
        
        // (3) 탭바 스타일 지정 및 뷰 컨트롤러 연결
        configureTabBarController(with: viewControllers)
        
        // (4) 'home' 페이지를 초기 페이지로 지정
        selectPage(.home)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 탭바 높이 변경
        setTabBarHeight()
    }
    
    
    // MARK: 주어진 페이지를 현재 페이지로 설정하는 메서드
    func selectPage(_ page: TabBarPage) {
        selectedIndex = page.pageIndex()
    }
    
    
    // MARK: 탭별 네비게이션 컨트롤러 및 뷰 컨트롤러 생성 메서드
    private func createTabNavigationController(for page: TabBarPage) -> UINavigationController {
        let viewController: UIViewController
        
        switch page {
        case .home:
            viewController = HomeViewController()
        case .lounge:
            viewController = LoungeViewController()
        case .category:
            viewController = CategoryViewController()
        case .search:
            viewController = SearchViewController()
        case .myPage:
            viewController = MyPageViewController()
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        navigationController.tabBarItem = UITabBarItem(
            title: page.pageName(),
            image: UIImage(named: page.defaultTabItemImageName()),
            selectedImage: UIImage(named: page.selectedTabItemImageName())
        )
        
        return navigationController
    }
    
    
    // MARK: 탭바 스타일 지정 및 초기화 메서드
    private func configureTabBarController(with navigationControllers: [UINavigationController]) {
        // TabBar의 ViewControllers 지정
        setViewControllers(navigationControllers, animated: false)
        
        // 이미지와 텍스트 사이 간격 조절
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0,
                                                                     vertical: -3)
        
        // 탭바 아이콘 및 배경색 변경
        tabBar.unselectedItemTintColor = .gray7
        tabBar.tintColor = .primary600
        tabBar.backgroundColor = .white
    }
    
    
    // MARK: 탭바 높이 설정 메서드
    private func setTabBarHeight() {
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 90
        tabBarFrame.origin.y = view.frame.size.height - 90
        tabBar.frame = tabBarFrame
    }
}

