//
//  SegmentedPageViewController.swift
//  MarketKurly
//
//  Created by 이세민 on 11/26/24.
//

import UIKit

import SnapKit

class SegmentedPageViewController: UIViewController {
    
    private let productId: Int
    
    private lazy var segmentController: UISegmentedControl = {
        let segment = UnderlineSegmentedControl(items: ["상품설명", "상세정보", "후기", "문의"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self,
                          action: #selector(segmentChanged(_:)),
                          for: .valueChanged)
        return segment
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.dataSource = self
        vc.delegate = self
        return vc
    }()
    
    private var viewControllers: [UIViewController] = []
    
    public init(productId: Int) {
        self.productId = productId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // segment control 뷰 컨트롤러 세팅
        self.viewControllers = [DetailViewController(productId: productId),
                                createViewController(text: "상세정보"),
                                ReviewViewController(),
                                createViewController(text: "문의")]
        
        setUI()
        setStyle()
        setLayout()
        setupInitialViewController()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .kurlyWhite
    }
    
    private func setUI() {
        addChild(pageViewController)
        view.addSubviews(segmentController, pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    private func setLayout() {
        segmentController.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(19)
            $0.height.equalTo(40)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentController.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupInitialViewController() {
        if let firstVC = viewControllers.first {
            pageViewController.setViewControllers([firstVC],
                                                  direction: .forward,
                                                  animated: true)
        }
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = index > (pageViewController.viewControllers?.first.flatMap { viewControllers.firstIndex(of: $0) } ?? 0) ? .forward : .reverse
        
        pageViewController.setViewControllers([viewControllers[index]],
                                              direction: direction,
                                              animated: true)
    }
    
    
    // MARK: 임시 뷰 컨트롤러
    private func createViewController(text: String) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .gray3
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.frame = vc.view.bounds
        vc.view.addSubview(label)
        
        return vc
    }
}

extension SegmentedPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return viewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else { return nil }
        return viewControllers[index + 1]
    }
}

extension SegmentedPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let currentVC = pageViewController.viewControllers?.first,
              let index = viewControllers.firstIndex(of: currentVC) else { return }
        
        segmentController.selectedSegmentIndex = index
    }
}
