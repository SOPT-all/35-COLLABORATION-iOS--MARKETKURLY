//
//  WishListCategoryTableViewCell.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/29/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then

struct WishListCategoryTabBar: View {
    let categoryList: [String]
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categoryList.indices, id: \.self) { index in
                    WishListCategory(
                        title: categoryList[index],
                        isSelected: index == selectedIndex
                    )
                    .onTapGesture {
                        withAnimation {
                            selectedIndex = index
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 44)
    }
}

struct WishListCategory: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(Font(MarketKurlyFont.captionMedium12.font))
            .foregroundColor(isSelected ? .white : Color(.gray6))
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(isSelected ? Color(.primary400) : .white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(isSelected ? Color.clear : Color(.gray3), lineWidth: 1)
                    )
            )
    }
}

class WishListCategoryTableViewCell: UITableViewCell {
    private var view = WishListCategoryTabBar(categoryList: [])
    
    private var hostingController: UIHostingController<WishListCategoryTabBar>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hostingController = UIHostingController(rootView: view)
        
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        if let hostingView = hostingController?.view {
            addSubview(hostingView)
        }
    }
    
    private func setLayout() {
        hostingController?.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with category: [String]) {
        view = WishListCategoryTabBar(categoryList: category)
        hostingController?.rootView = view
    }
}
