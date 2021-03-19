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
}

extension UIImageView {
    func circular() {
        self.cornerRadius = self.bounds.size.width/2
    }
}
