//
//  CustomTabbar.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/20/21.
//

import UIKit

class CustomTabBar: UIView {
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    let itemImageSize: CGFloat = 40.0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)

        layer.backgroundColor = UIColor.white.cgColor
        
        let itemBackgroundView = UIImageView()
        itemBackgroundView.image = UIImage.tabSelectedBackground.withRenderingMode(.automatic)
        itemBackgroundView.frame = CGRect(x: 0, y: 0, width: UIImage.tabSelectedBackground.size.width, height: UIImage.tabSelectedBackground.size.height)
        itemBackgroundView.clipsToBounds = true
        itemBackgroundView.contentMode = .center
        itemBackgroundView.tag = 100
        addSubview(itemBackgroundView)
        
        let separator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 0.5))
        separator.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(separator)
        
        // Khởi tạo từng tab bar item
        for index in 0 ..< menuItems.count {
            let itemWidth = frame.width / CGFloat(menuItems.count)
            let offsetX = itemWidth * CGFloat(index)

            let itemView = createTabItem(item: menuItems[index])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = index
            

            addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: heightAnchor),
                itemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offsetX),
                itemView.topAnchor.constraint(equalTo: topAnchor),
            ])
        }


        setNeedsLayout()
        layoutIfNeeded()
        activateTab(tab: 2)
    }

    func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView()
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true

        let itemImageView = UIImageView()
        itemImageView.image = item.icon.withRenderingMode(.alwaysTemplate)
        itemImageView.backgroundColor = .clear
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .center
        itemImageView.tintColor = .tabbarUnselectedTintColor
        itemImageView.tag = 101
        

        tabBarItem.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: itemImageSize),
            itemImageView.widthAnchor.constraint(equalToConstant: itemImageSize),
            itemImageView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemImageView.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor, constant: ((frame.size.width/CGFloat(TabItem.allCases.count)) - itemImageSize)/2),

        ])

        // Thêm tap gesture recognizer để handle tap event
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))

        return tabBarItem
    }

    @objc func handleTap(_ sender: UIGestureRecognizer) {
        switchTab(from: activeItem, to: sender.view!.tag)
    }

    func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }

    func activateTab(tab: Int) {
        let tabToActivate = subviews[tab+2] // + 2 do add trước đó 2 subview
        if let backgroundImage = viewWithTag(100) as? UIImageView,
           let itemImage = tabToActivate.viewWithTag(101) as? UIImageView {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut]) {
                backgroundImage.center = CGPoint(x: tabToActivate.center.x, y: itemImage.center.y)
            } completion: { (_) in
                backgroundImage.layoutIfNeeded()
            }
            itemImage.tintColor = .tabbarSelectedTintColor
        }
        self.itemTapped?(tab)
        self.activeItem = tab
    }

    func deactivateTab(tab: Int) {
        let inactiveTab = subviews[tab+2]
        if let itemImage = inactiveTab.viewWithTag(101) as? UIImageView {
            itemImage.tintColor = .tabbarUnselectedTintColor
        }
    }
}
