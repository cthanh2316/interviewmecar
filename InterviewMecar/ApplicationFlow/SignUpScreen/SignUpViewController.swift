//
//  SignUpViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit
import Firebase

protocol SignUpViewControllerDelegate {
    func resgisterSuccess(email: String, password: String)
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var cstTopTxtPassword: NSLayoutConstraint!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tvLegal: UITextView!
    
    var delegate: SignUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addActionDismissKeyboard()
    }
    
    private func configureView() {
        lblTitle.text = "Register".localized()
        lblTitle.font = UIFont.titleFont
        lblTitle.addCharacterSpacing(kernValue: .kernTitleValue)
        
        txtEmail.borderWidth = .borderWidth
        txtEmail.borderColor = .borderColor
        txtEmail.setLeftPaddingPoints(.leftRightPadding)
        txtEmail.setRightPaddingPoints(.leftRightPadding)
        txtEmail.font = UIFont.textFieldFont
        txtEmail.placeholder = "yourname@email.com".localized()
        txtEmail.delegate = self
        
        txtPassword.borderWidth = .borderWidth
        txtPassword.borderColor = .borderColor
        txtPassword.setLeftPaddingPoints(.leftRightPadding)
        txtPassword.setRightPaddingPoints(.leftRightPadding)
        txtPassword.font = UIFont.textFieldFont
        txtPassword.placeholder = "Password".localized()
        txtPassword.delegate = self
        
        btnSignUp.setTitle("Sign up".localized().uppercased(), for: .normal)
        btnSignUp.titleLabel?.font = UIFont.btnTitleFont
        btnSignUp.titleLabel?.addCharacterSpacing(kernValue: .kernBtnValue)
        btnSignUp.isEnabled = txtEmail.text?.isValidEmail ?? false
        
        configureLegalContent()
    }
    
    private func configureLegalContent() {
        let string = "By signing up, you agree to Photo’s Terms of Service and Privacy Policy.".localized()
        let attributedString = NSMutableAttributedString(string: string)
        let url = URL(string: "https://www.apple.com")!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.18
        
        attributedString.setAttributes([.font: UIFont(styleRoboto: .Regular, ofSize: 13.0),
                                        .foregroundColor : UIColor.black,
                                        .paragraphStyle: paragraphStyle], range: NSMakeRange(0, string.count - 1))
        let termRange = NSString(string: string).range(of: "Terms of Service".localized())
        let policyRange = NSString(string: string).range(of: "Privacy Policy".localized())
        attributedString.setAttributes([.link: url], range: termRange)
        attributedString.setAttributes([.link: url], range: policyRange)
        
        self.tvLegal.attributedText = attributedString
        self.tvLegal.isUserInteractionEnabled = true
        self.tvLegal.isEditable = false

        self.tvLegal.linkTextAttributes = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    @IBAction func txtEmailEditingChanged(_ sender: Any) {
        if let email = txtEmail.text {
            btnSignUp.isEnabled = email.isValidEmail
            if email.isValidEmail {
                UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
                    self.cstTopTxtPassword.constant = 16
                    self.view.layoutIfNeeded()
                } completion: { (_) in
                    
                }
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) {
                    self.cstTopTxtPassword.constant = -self.txtPassword.bounds.size.height
                    self.view.layoutIfNeeded()
                } completion: { (_) in
                    self.txtPassword.text = ""
                }
            }
        }
    }
    
    private func signUp(email: String, password: String) {
        self.showLoading()
        FirebaseManager.auth.createUser(email:email , password: password) { [weak self] (success, user, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.hideLoading()
            if success {
                self?.showAlert(title: "", message: "Sign up success".localized(), actionTitle: "Log in".localized().uppercased(), actionHandling: {
                    strongSelf.dismiss(animated: false) {
                        strongSelf.delegate?.resgisterSuccess(email: email, password: password)
                    }
                })
                
            } else {
                strongSelf.showAlert(title: "", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    @IBAction func onActionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onActionSignUp(_ sender: Any) {
        if let email = txtEmail.text, email.isValidEmail, let password = txtPassword.text {
            self.signUp(email: email, password: password)

        } else {
            self.showAlert(title: "", message: "Invalid email or password.".localized())
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
            txtPassword.becomeFirstResponder()
            return true
        } else if textField == self.txtPassword {
            if let email = txtEmail.text, email.isValidEmail, let password = textField.text, !password.isEmpty {
                self.signUp(email: email, password: password)
                textField.resignFirstResponder()
                return true
            } else {
                showAlert(title: "", message: "Invalid email or password.".localized())
                return false
            }
        }
        return false
    }
}

