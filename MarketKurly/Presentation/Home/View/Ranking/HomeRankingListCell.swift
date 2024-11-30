//
//  HomeRankingListCell.swift
//  MarketKurly
//
//  Created by 최지석 on 11/27/24.
//

import UIKit
import SwiftUI
import SnapKit
import Then

//final class HomeRankingListCell: UICollectionViewCell {
//    
//    private let containerView = UIView().then {
//        $0.backgroundColor = .white
//        $0.layer.cornerRadius = 10
//        $0.clipsToBounds = true
//    }
//    
//    private let productImageView = UIImageView().then {
//        $0.layer.cornerRadius = 5
//        $0.clipsToBounds = true
//        $0.contentMode = .scaleAspectFill
//        $0.backgroundColor = .coolGray2
//    }
//    
//    private let rankingLabel = UILabel()
//    
//    private let productInfoContainerView = UIStackView().then {
//        $0.axis = .horizontal
//        $0.alignment = .center
//        $0.spacing = 14
//    }
//    
//    private let productContentsStackView = UIStackView().then {
//        $0.axis = .vertical
//        $0.alignment = .leading
//        $0.spacing = 1
//    }
//    
//    private let productNameLabel = UILabel().then {
//        $0.numberOfLines = 2
//    }
//    
//    private let salePriceStackView = UIStackView().then {
//        $0.axis = .horizontal
//        $0.alignment = .center
//        $0.spacing = 4
//    }
//    
//    private let discountRateLabel = UILabel()
//    
//    private let salePriceLabel = UILabel()
//    
//    private let cartButton = UIButton().then {
//        var config = UIButton.Configuration.plain()
//        
//        let image = UIImage(named: "icon_home_cart_small")
//        config.image = image
//        config.imagePadding = 1 // 이미지와 텍스트 사이 간격
//        
//        // 텍스트 설정
//        config.attributedTitle = AttributedString(.makeAttributedString(text: "담기",
//                                                                        color: .gray7,
//                                                                        font: MarketKurlyFont.captionMedium12.font,
//                                                                        textAlignment: .center))
//        
//        // 테두리 및 border 설정
//        config.background.strokeWidth = 1
//        config.background.strokeColor = UIColor.coolGray2
//        config.background.cornerRadius = 4
//        
//        $0.configuration = config
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        makeUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        clearUI()
//    }
//    
//    private func makeUI() {
//        contentView.addSubview(
//            containerView.addSubviews(
//                productImageView,
//                productInfoContainerView.addArrangedSubviews(
//                    rankingLabel,
//                    productContentsStackView.addArrangedSubviews(
//                        productNameLabel,
//                        salePriceStackView.addArrangedSubviews(
//                            discountRateLabel,
//                            salePriceLabel
//                        )
//                    )
//                ),
//                cartButton
//            )
//        )
//        
//        containerView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        productImageView.snp.makeConstraints {
//            $0.height.equalTo(225)
//            $0.width.equalTo(183)
//            $0.top.left.right.equalToSuperview()
//        }
//        
//        cartButton.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(12)
//            $0.horizontalEdges.equalToSuperview().inset(12)
//            $0.height.equalTo(30)
//        }
//        
//        productInfoContainerView.snp.makeConstraints {
//            $0.top.equalTo(productImageView.snp.bottom)
//            $0.bottom.equalTo(cartButton.snp.top)
//            $0.horizontalEdges.equalToSuperview().inset(12)
//        }
//    }
//    
//    
//    public func setUI(with item: HomeRankingListItem, cellIndex: Int) {
//        
//        if let productImage = item.image {
//            let imageURL = URL(string: productImage)
//            productImageView.kf.setImage(with: imageURL)
//        }
//        
//        rankingLabel.attributedText = .makeAttributedString(text: "\(cellIndex)",
//                                                            color: .gray7,
//                                                            font: MarketKurlyFont.titleBold32.font)
//        
//        if let productName = item.name {
//            productNameLabel.attributedText = .makeAttributedString(text: productName,
//                                                                    color: .gray8,
//                                                                    font: MarketKurlyFont.bodyMedium14.font)
//        }
//        
//        if let discountRate = item.discount {
//            discountRateLabel.attributedText = .makeAttributedString(text: "\(discountRate)%",
//                                                                     color: .kurlyRed,
//                                                                     font: MarketKurlyFont.bodyBold14.font)
//        }
//        
//        if let salePrice = item.price,
//           let formattedSalePrice = Formatter.currency.string(for: salePrice) {
//            salePriceLabel.attributedText = .makeAttributedString(text: formattedSalePrice + "원",
//                                                                  color: .gray8,
//                                                                  font: MarketKurlyFont.bodyBold14.font)
//        }
//    }
//    
//    
//    private func clearUI() {
//        productImageView.image = nil
//        productNameLabel.attributedText = nil
//        discountRateLabel.attributedText = nil
//        salePriceLabel.attributedText = nil
//    }
//}

final class HomeRankingListCell: UICollectionViewCell {
    
    private weak var hostingController: UIHostingController<HomeRankingListCellView>?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setUI(with item: HomeRankingListItem, cellIndex: Int) {
        
        let rankingView = HomeRankingListCellView(item: item,
                                                  cellIndex: cellIndex)
        
        if let hostingController {
            hostingController.rootView = rankingView
        } else {
            let hostingController = UIHostingController(rootView: rankingView)
            hostingController.view.backgroundColor = .clear
            
            contentView.addSubview(hostingController.view)
            hostingController.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }

            self.hostingController = hostingController
        }
    }
}



struct HomeRankingListCellView: View {
    
    let item: HomeRankingListItem
    let cellIndex: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 상품 이미지
            if let imageUrl = item.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 183, height: 225)
                        .clipShape(
                            RoundedCornerShape(corners: [.topLeft, .topRight], radius: 10)
                        )
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .frame(width: 183, height: 225)
                        .cornerRadius(5)
                }
            }
            
            Spacer().frame(height: 16)
            
            // 랭킹과 상품 정보
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 14) {
                    // 랭킹 번호
                    Text("\(cellIndex)")
                        .font(Font(MarketKurlyFont.titleBold32.font))
                        .foregroundColor(.gray7)
                    
                    // 상품 이름 및 할인/가격 정보
                    VStack(alignment: .leading, spacing: 1) {
                        if let name = item.name {
                            Text(name)
                                .font(Font(MarketKurlyFont.bodyMedium14.font))
                                .foregroundColor(.gray8)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading) // 너비를 부모 뷰에 맞춤
                        }
                        
                        HStack(spacing: 4) {
                            if let discount = item.discount {
                                Text("\(discount)%")
                                    .font(Font(MarketKurlyFont.bodyBold14.font))
                                    .foregroundColor(.kurlyRed)
                            }
                            
                            if let price = item.price {
                                Text("\(price)원")
                                    .font(Font(MarketKurlyFont.bodyBold14.font))
                                    .foregroundColor(.gray7)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 55)
            
            Spacer()
                .frame(height: 6)
            
            // 담기 버튼
            Button(action: {
                // TODO: Action
            }) {
                HStack(alignment: .center, spacing: 1) {
                    Image("icon_home_cart_small")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    
                    Text("담기")
                        .font(Font(MarketKurlyFont.captionMedium12.font))
                        .foregroundColor(.gray7)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.coolGray2, lineWidth: 1)
                )
            }
            .padding(.horizontal, 12)
            
            Spacer()
                .frame(height: 12)
        }
        .frame(width: 183, height: 344)
        .background(Color.white)
        .cornerRadius(10)
    }
}


struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
