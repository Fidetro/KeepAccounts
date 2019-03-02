//
//  TabBarController.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/23.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupItemStyle()
        self.tabBar.tintColor = .white
        self.tabBar.backgroundImage = UIImage()
    }
    func setupChildControllers() {
        let firstNaVC = BaseNavigationController.init(rootViewController: TodayViewController())
        let secondNaVC = BaseNavigationController.init(rootViewController: AddBillViewController())
        let thirdNaVC = BaseNavigationController.init(rootViewController: CalendarViewController())
        
        self.addChild(firstNaVC)
        self.addChild(secondNaVC)
        self.addChild(thirdNaVC)
        
    }
    
    func setupItemStyle() {
        
        self.viewControllers?[0].tabBarItem = tabBarItemWithTitle("今日", image: UIImage.init(named: "ic_home"), tag: 0)
        self.viewControllers?[1].tabBarItem = tabBarItemWithTitle("账单", image: UIImage.init(named: "ic_search"), tag: 0)
        self.viewControllers?[2].tabBarItem = tabBarItemWithTitle("日历", image: UIImage.init(named: "ic_search"), tag: 0)
        
    }
    
    func tabBarItemWithTitle(_ title:String,image:UIImage? ,tag:Int) -> UITabBarItem {
        let newImage = image?.withRenderingMode(.alwaysOriginal)
        let item = UITabBarItem.init(title: title, image: newImage, tag: tag)
        
        return item
    }
    
}

// MARK: setup view
extension TabBarController {
    
}

// MARK: view delegate
extension TabBarController {
    
}
