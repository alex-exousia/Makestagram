//
//  MainTabBarController.swift
//  Makestagram
//
//  Created by Alexander Niehaus on 7/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//
import UIKit
import Foundation
class MainTabBarController: UITabBarController {
    
    let photoHelper = MGPhotoHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            PostService.create(for: image)       }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController:
        UIViewController) -> Bool {
            if viewController.tabBarItem.tag == 1 {
                photoHelper.presentActionSheet(from: self)
                return false
            } else {
                return true
        }
    }
}
