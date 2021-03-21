//
//  Enums.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import Foundation

enum AppConfig: String {
    case Language = "current_lang"
}

enum CollectionViewCellName: String {
    case photoCell = "PhotoCollectionViewCell"
    
    static var photo = photoCell.rawValue
}

enum TableviewCellName: String {
    case ProfileCell = "ProfileTableviewCell"
    
    static var profile = ProfileCell.rawValue
}
