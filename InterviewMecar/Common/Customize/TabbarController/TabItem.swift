//
//  TabbarItem.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/20/21.
//

import UIKit

enum TabItem: String, CaseIterable {
    case home = "home"
    case search = "search"
    case new = "new"
    case messages = "messages"
    case profile = "profile"
    
    var viewController: UIViewController {
        switch self {
        case .home:
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let homeNC = UINavigationController(rootViewController: homeVC)
            return homeNC
        case .search:
            let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
            let searchNC = UINavigationController(rootViewController: searchVC)
            return searchNC
        case .new:
            let addPhotoVC = AddPhotoViewController(nibName: "AddPhotoViewController", bundle: nil)
            let addPhotoNC = UINavigationController(rootViewController: addPhotoVC)
            return addPhotoNC
        case .messages:
            let messageVC = MessageViewController(nibName: "MessageViewController", bundle: nil)
            let messageNC = UINavigationController(rootViewController: messageVC)
            return messageNC
        case .profile:
            let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            let profileNC = UINavigationController(rootViewController: profileVC)
            return profileNC
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return UIImage.tabHome
        case .search:
            return UIImage.tabSearch
        case .new:
            return UIImage.tabNew
        case .messages:
            return UIImage.tabMessage
        case .profile:
            return UIImage.tabProfile
        }
    }

    var displayTitle: String {
        return ""
    }
}
