//
//  LoginViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addActionDismissKeyboard()
    }
    
    private func configureView() {
        lblTitle.text = "Log in".localized()
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
        
        btnLogin.setTitle("Log in".localized().uppercased(), for: .normal)
        btnLogin.titleLabel?.font = UIFont.btnTitleFont
        btnLogin.titleLabel?.addCharacterSpacing(kernValue: .kernBtnValue)
        btnLogin.isEnabled = txtEmail.text?.isValidEmail ?? false
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if let email = txtEmail.text, let password = txtPassword.text {
            btnLogin.isEnabled = email.isValidEmail && !password.isEmpty // Cần validate password, tạm != ""
        }
    }
    
    @IBAction func onActionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onActionLogin(_ sender: Any) {
        // TODO: Handle login with firebase Auth
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
            txtPassword.becomeFirstResponder()
            return true
        } else if textField == self.txtPassword {
            if let email = txtEmail.text, email.isValidEmail, let password = textField.text, !password.isEmpty {
                // TODO: Call firebase auth
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
