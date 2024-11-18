//
//  MarketKurlyFont.swift
//  MarketKurly
//
//  Created by 우상욱 on 11/18/24.
//

import UIKit

public enum MarketKurlyFont {
    // MARK: - Title
    case titleBold32
    case titleEmoji22
    case titleSemiBold18
    case titleBody18
    case titleCaption14
    
    // MARK: - Body
    case bodyBold24
    case bodyRegular18
    case bodyBold16
    case bodyMedium16
    case bodySemiBold14
    
    // MARK: - Caption
    case captionSemiBold12
    case captionMedium12
    case captionRegular12
    case captionBold10
    case captionBold7
}

extension MarketKurlyFont {
    public var font: UIFont {
        switch self {
        // MARK: - Title
        case .titleBold32:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 32)!
                .withLineHeight(34)
                .withLetterSpacing(0)
        case .titleEmoji22:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 22)!
                .withLineHeight(20)
                .withLetterSpacing(0)
        case .titleSemiBold18:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!
                .withLineHeight(22)
                .withLetterSpacing(-2)
        case .titleBody18:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!
                .withLineHeight(20)
                .withLetterSpacing(0)
        case .titleCaption14:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!
                .withLineHeight(18)
                .withLetterSpacing(2)
            
        // MARK: - Body
        case .bodyBold24:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 24)!
                .withLineHeight(28)
                .withLetterSpacing(2)
        case .bodyRegular18:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!
                .withLineHeight(20)
                .withLetterSpacing(0)
        case .bodyBold16:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!
                .withLineHeight(20)
                .withLetterSpacing(-3)
        case .bodyMedium16:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!
                .withLineHeight(20)
                .withLetterSpacing(1)
        case .bodySemiBold14:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)!
                .withLineHeight(18)
                .withLetterSpacing(2)
            
        // MARK: - Caption
        case .captionSemiBold12:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)!
                .withLineHeight(16)
                .withLetterSpacing(0)
        case .captionMedium12:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 12)!
                .withLineHeight(16)
                .withLetterSpacing(2)
        case .captionRegular12:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
                .withLineHeight(16)
                .withLetterSpacing(2)
        case .captionBold10:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 10)!
                .withLineHeight(14)
                .withLetterSpacing(-1)
        case .captionBold7:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: 7)!
                .withLineHeight(7)
                .withLetterSpacing(-1)
        }
    }
}
