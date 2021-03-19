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

enum Comfortaa: String {
    case Bold = "Comfortaa-Bold"
    case Regular = "Comfortaa-Regular"
    case Light = "Comfortaa-Light"
}

extension UIFont {
    convenience init(styleRoboto style: Roboto, ofSize size: CGFloat) {
        self.init(name: style.rawValue, size: size)!
    }
    
    convenience init(styleComfortaa style: Comfortaa, ofSize size: CGFloat) {
        self.init(name: style.rawValue, size: size)!
    }
    
    static var btnTitleFont: UIFont {
        return UIFont(styleRoboto: .Black, ofSize: 13.0)
    }
    
    static var titleFont: UIFont {
        return UIFont(styleComfortaa: .Regular, ofSize: 36.0)
    }
    
    static var lblName: UIFont {
        return UIFont(styleRoboto: .Bold, ofSize: 13.0)
    }
    
    static var lblSubName: UIFont {
        return UIFont(styleRoboto: .Regular, ofSize: 11.0)
    }
    
    static var textFieldFont: UIFont {
        return UIFont(styleRoboto: .Regular, ofSize: 15.0)
    }
}
