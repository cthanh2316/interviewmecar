//
//  IntoduceViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

class IntoduceViewController: UIViewController {

    @IBOutlet weak var imvLogo: UIImageView!
    @IBOutlet weak var imvBackground: UIImageView!
    @IBOutlet weak var imvAuthorAvatar: UIImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblAuthorSigned: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        
        imvBackground.image = UIImage.background
        imvLogo.image = UIImage.logo
        imvAuthorAvatar.image = UIImage.authorAvatar
        imvAuthorAvatar.circular()
        
        lblAuthorName.font = .lblName
        lblAuthorName.textColor = .lblNameColor
        lblAuthorSigned.font = .lblSubName
        lblAuthorSigned.textColor = .lblSubnameColor
        
        btnLogin.cornerRadius = .btnRadius
        btnLogin.borderWidth = .borderWidth
        btnLogin.borderColor = .borderColor
        btnLogin.backgroundColor = .loginBgColor
        btnLogin.setTitleColor(.loginTextColor, for: .normal)
        btnLogin.titleLabel?.font = UIFont.btnTitleFont
        btnLogin.titleLabel?.addCharacterSpacing(kernValue: .kernBtnValue)
        btnLogin.setTitle("Log in".localized().uppercased(), for: .normal)
        
        btnRegister.cornerRadius = .btnRadius
        btnRegister.borderWidth = 0.0
        btnRegister.backgroundColor = .registerBgColor
        btnRegister.setTitleColor(.registerTextColor, for: .normal)
        btnRegister.titleLabel?.font = UIFont.btnTitleFont
        btnRegister.titleLabel?.addCharacterSpacing(kernValue: .kernBtnValue)
        btnRegister.setTitle("Register".localized().uppercased(), for: .normal)

    }
    
    private func gotoLoginScreen(email: String = "", password: String = "") {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginVC.userName = email
        loginVC.password = password
        loginVC.delegate = self
        loginVC.modalPresentationStyle = .overFullScreen
        self.present(loginVC, animated: true)
    }
    
    @IBAction func onActionLogin(_ sender: Any) {
        gotoLoginScreen()
    }
    
    @IBAction func onActionRegister(_ sender: Any) {
        let signupVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        signupVC.delegate = self
        signupVC.modalPresentationStyle = .overFullScreen
        self.present(signupVC, animated: true)
    }
}

extension IntoduceViewController: SignUpViewControllerDelegate {
    func resgisterSuccess(email: String, password: String) {
        print("Register success")
        gotoLoginScreen(email: email, password: password)
    }
}

extension IntoduceViewController: LoginViewControllerDelegate {
    func loginSuccess() {
        print("Login success")
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.gotoTabbarController()
        }
    }
}
