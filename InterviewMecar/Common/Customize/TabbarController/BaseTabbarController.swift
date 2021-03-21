//
//  BaseTabbarController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/20/21.
//

import UIKit

class BaseTabBarController: UITabBarController {
    var customTabBar: CustomTabBar!
    var tabBarHeight: CGFloat = .tabbarHeight

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    func loadTabBar() {
        let tabbarItems: [TabItem] = [.home, .search, .new, .messages, .profile]

        setupCustomTabMenu(tabbarItems, completion: { viewControllers in
            self.viewControllers = viewControllers
        })

        selectedIndex = 2 // Set default selected index thành item đầu tiên
    }

    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()

        // Ẩn tab bar mặc định của hệ thống đi
        tabBar.isHidden = true
        // Khởi tạo custom tab bar
        customTabBar = CustomTabBar(menuItems: menuItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = changeTab(tab:)
        view.addSubview(customTabBar)
        view.backgroundColor = .white

        // Auto layout cho custom tab bar
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight + view.safeAreaInsets.bottom),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Thêm các view controller tương ứng
        menuItems.forEach({
            controllers.append($0.viewController)
        })

        view.layoutIfNeeded()
        completion(controllers)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
