//
//  WishListCategoryCollectionView.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/28/24.
//

import UIKit

class WishListCategoryCollectionView: UITableViewCell {
    private var categoryList : [String]?
    private var selectedIndex : Int?
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            $0.minimumLineSpacing = 8
            $0.minimumInteritemSpacing = 8
        }
    ).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        $0.register(WishListCategoryCollectionViewCell.self, forCellWithReuseIdentifier: WishListCategoryCollectionViewCell.identifier)
        $0.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setStyle() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(data: [String], index: Int){
        categoryList = data
        selectedIndex = index
    }
}

extension WishListCategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCategoryCollectionViewCell.identifier, for: indexPath) as? WishListCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let categoryList = categoryList {
            item.configure(title: categoryList[indexPath.row], isSelected: indexPath.row == selectedIndex)
        }
        return item
    }
    
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            let text = categoryList?[indexPath.item]
            let cellWidth = (text! as NSString).boundingRect(
                with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: collectionView.bounds.height),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: MarketKurlyFont.captionMedium12.font],
                context: nil
            ).width
            
            return CGSize(width: cellWidth + 16, height: 28)
        }
}
