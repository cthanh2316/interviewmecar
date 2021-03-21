//
//  UIViewController+Extension.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

extension UIViewController {
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) +
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
    
    func showLoading(message: String = "Please wait...".localized()) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoading() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            vc.dismiss(animated: false, completion: nil)
        }
    }
}
