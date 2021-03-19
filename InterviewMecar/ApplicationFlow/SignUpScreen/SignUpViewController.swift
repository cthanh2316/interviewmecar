//
//  SignUpViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tvLegal: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        lblTitle.text = "Register".localized()
        lblTitle.font = UIFont.titleFont
        lblTitle.addCharacterSpacing(kernValue: .kernTitleValue)
        
        txtEmail.borderWidth = .borderWidth
        txtEmail.borderColor = .borderColor
        txtEmail.setLeftPaddingPoints(.leftRightPadding)
        txtEmail.setRightPaddingPoints(.leftRightPadding)
        txtEmail.font = UIFont(styleRoboto: .Regular, ofSize: 15.0)
        txtEmail.placeholder = "yourname@email.com".localized()
        
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
        }
    }
    
    @IBAction func onActionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onActionSignUp(_ sender: Any) {
        // TODO: Register account
    }
}

