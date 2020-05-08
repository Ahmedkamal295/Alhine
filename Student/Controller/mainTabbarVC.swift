//
//  mainTabbarVC.swift
//  Student
//
//  Created by MOHAB on 2/1/20.
//  Copyright © 2020 e3gaz. All rights reserved.
//

import UIKit

class mainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == self.tabBar.items![3]{
            guard let _ = Helper.getapitoken() else{
               
                self.showAlertWithTitle(title: "", message: "you should login first", type: .warning)
                return}
            self.selectedIndex = 3
        }
    }
    
}
