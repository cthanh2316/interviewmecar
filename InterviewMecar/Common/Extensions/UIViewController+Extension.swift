//
//  UIViewController+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

extension UIViewController {
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func showAlert(title: String, message: String, actionTitle: String = "Cancel".localized(), actionHandling: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            if let actionHandle = actionHandling {
                actionHandle()
            }
            alertVC.dismiss(animated: true)
        }
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }
    
    func addActionDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
