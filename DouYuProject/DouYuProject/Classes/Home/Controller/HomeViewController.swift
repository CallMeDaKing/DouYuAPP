//
//  HomeViewController.swift
//  DouYuProject
//
//  Created by li king on 2017/10/26.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setUpUI()
    }
}

extension HomeViewController{
    
    private func setUpUI(){
        
        //设置导航栏
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar(){
        
        //设置左侧的item
      /* let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        */
         let size = CGSize(width: 40, height: 40)
 
        //设置右侧的item
      /*   let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named:"image_my_history"), for: .normal)
        historyBtn.setImage(UIImage(named:"Image_my_history_click"), for: .highlighted)
        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let historyItem =  UIBarButtonItem(customView: historyBtn)
        
        let serchBtn = UIButton()
        serchBtn.setImage(UIImage(named:"btn_search"), for: .normal)
        serchBtn.setImage(UIImage(named:"btn_search_clicked"), for: .highlighted)
        serchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let searchitem = UIBarButtonItem(customView: serchBtn)
        
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named:"Image_scan"), for: .normal)
        qrcodeBtn.setImage(UIImage(named:"Image_scan_click"), for: .highlighted)
        qrcodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
     */
        //方法二 优化方法一 ，使用类扩展的方式 直接创建 四个 但是swift 中用更多的是构造函数
        
     /*let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highLightImageLName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.creatItem(imageName: "btn_search", highLightImageLName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highLightImageLName: "Image_scan_click", size: size)
        
        */
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highLightImageLName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highLightImageLName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highLightImageLName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}
