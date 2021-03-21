//
//  UIColor+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}

extension UIColor {
    
    static var borderColor: UIColor {
        return UIColor.black
    }
    
    static var loginBgColor: UIColor {
        return UIColor.white
    }
    
    static var loginTextColor: UIColor {
        return UIColor.black
    }
    
    static var registerBgColor: UIColor {
        return UIColor.black
    }
    
    static var registerTextColor: UIColor {
        return UIColor.white
    }
    
    static var tabbarSelectedTintColor: UIColor {
        return UIColor.white
    }
    
    static var tabbarBackgroundColor: UIColor {
        return UIColor.white
    }
    
    static var tabbarUnselectedTintColor: UIColor {
        return UIColor.black
    }
    
}
