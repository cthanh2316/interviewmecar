//
//  UIFont+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

enum Roboto : String {
    case Black = "Roboto-Black"
    case BlackItalic = "Roboto-BlackItalic"
    case Bold = "Roboto-Bold"
    case BoldItalic = "Roboto-BoldItalic"
    case Italic = "Roboto-Italic"
    case Light = "Roboto-Light"
    case LightItalic = "Roboto-LightItalic"
    case Medium = "Roboto-Medium"
    case MediumItalic = "Roboto-MediumItalic"
    case Regular = "Roboto-Regular"
    case Thin = "Roboto-Thin"
    case ThinItalic = "Roboto-ThinItalic"
    case CondensedBold = "RobotoCondensed-Bold"
    case CondensedBoldItalic = "RobotoCondensed-BoldItalic"
    case CondensedItalic = "RobotoCondensed-Italic"
    case CondensedLight = "RobotoCondensed-Light"
    case CondensedLightItalic = "RobotoCondensed-LightItalic"
    case CondensedRegular = "RobotoCondensed-Regular"
}

extension UIFont {
    convenience init(style: Roboto, ofSize size: CGFloat) {
        self.init(name: style.rawValue, size: size)!
    }
}
