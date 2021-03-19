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
        
        lblAuthorName.font = UIFont(style: .Bold, ofSize: 13.0)
        lblAuthorSigned.font = UIFont(style: .Regular, ofSize: 11.0)
        
        btnLogin.cornerRadius = 6.0
        btnLogin.borderWidth = 2.0
        btnLogin.borderColor = .borderColor
        btnLogin.backgroundColor = .loginBgColor
        btnLogin.setTitleColor(.loginTextColor, for: .normal)
        btnLogin.titleLabel?.font = UIFont(style: .Black, ofSize: 13.0)
        btnLogin.titleLabel?.addCharacterSpacing(kernValue: 0.52)
        btnLogin.setTitle("LOG IN", for: .normal)
        
        btnRegister.cornerRadius = 6.0
        btnRegister.borderWidth = 0.0
        btnRegister.backgroundColor = .registerBgColor
        btnRegister.setTitleColor(.registerTextColor, for: .normal)
        btnRegister.titleLabel?.font = UIFont(style: .Black, ofSize: 13.0)
        btnRegister.titleLabel?.addCharacterSpacing(kernValue: 0.52)
        btnRegister.setTitle("REGISTER", for: .normal)

    }
    
    @IBAction func onActionLogin(_ sender: Any) {
        // TODO: Present Login screen
    }
    
    @IBAction func onActionRegister(_ sender: Any) {
        // TODO: Present Register screen
    }
}
