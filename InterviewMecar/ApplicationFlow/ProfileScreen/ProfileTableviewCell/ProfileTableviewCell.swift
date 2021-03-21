//
//  ProfileTableviewCell.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/21/21.
//

import UIKit

class ProfileTableviewCell: UITableViewCell {

    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.profileTitleFont
    }

    func configureCell(style: ListProfileCell) {
        switch style {
        case .signOut:
            imvIcon.image = UIImage.signOutImage
            lblTitle.text = style.rawValue.localized()
        }
    }
    
}
