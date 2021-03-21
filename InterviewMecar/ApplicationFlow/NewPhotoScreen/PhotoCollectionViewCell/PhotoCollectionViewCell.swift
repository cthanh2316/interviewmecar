//
//  PhotoCollectionViewCell.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/21/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imvPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imvPhoto.image = nil
    }

}
