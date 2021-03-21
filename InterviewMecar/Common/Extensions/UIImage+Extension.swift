//
//  UIImage+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

extension UIImage {
    
    static var background: UIImage {
        return UIImage(named: "Background")!
    }
    
    static var logo: UIImage {
        return UIImage(named: "Logo")!
    }
    
    static var authorAvatar: UIImage {
        return UIImage(named: "AuthorAvatar")!
    }
    
    static var tabHome: UIImage {
        return UIImage(named: "Icon_Home")!
    }
    
    static var tabSearch: UIImage {
        return UIImage(named: "Icon_Search")!
    }
    
    static var tabNew: UIImage {
        return UIImage(named: "Icon_New")!
    }
    
    static var tabMessage: UIImage {
        return UIImage(named: "Icon_Message")!
    }
    
    static var tabProfile: UIImage {
        return UIImage(named: "Icon_Profile")!
    }
    
    static var tabSelectedBackground: UIImage {
        return UIImage(named: "Tabbar_Background")!
    }
    
    static var placeholderImage: UIImage {
        return UIImage(named: "placeholder-image")!
    }
    
    static var signOutImage: UIImage {
        return UIImage(named: "Icon_Signout")!
    }

}

extension UIImageView {
    func circular() {
        self.cornerRadius = self.bounds.size.width/2
    }
}
