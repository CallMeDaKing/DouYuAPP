//
//  MainViewController.swift
//  DouYuProject
//
//  Created by li king on 2017/10/26.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyBoardName: "Home")
        addChildVc(storyBoardName: "Live")
        addChildVc(storyBoardName: "Follow")
        addChildVc(storyBoardName: "Profile")
        
    }
    
    private func addChildVc(storyBoardName: String){
        
        //通过storyboard 获取控制器
        let childVc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        //将childVc 做为自控制器
        addChildViewController(childVc)
        
    }
}
