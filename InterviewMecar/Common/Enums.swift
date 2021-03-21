//
//  Enums.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import Foundation

enum Languages: String {
    case english = "en"
    case vietnamese = "vi"
}

enum AppConfig: String {
    case LanguagesKey = "current_lang"
}

enum NotificationName {
    static let changedLanguages = "changedLanguages"
}

enum CollectionViewCellName: String {
    case photoCell = "PhotoCollectionViewCell"
    
    static var photo = photoCell.rawValue
}

enum TableviewCellName: String {
    case ProfileCell = "ProfileTableviewCell"
    
    static var profile = ProfileCell.rawValue
}
