//
//  UIDevice+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/21/21.
//

import UIKit

extension UIDevice {
    /// Returns `true` if the device has a notch
    static var hasNotch: Bool {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            return sd.window?.safeAreaInsets.top ?? 0.0 > 20
        }
        return false
    }
}
