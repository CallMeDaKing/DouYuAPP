//
//  HomeViewController.swift
//  DouYuProject
//
//  Created by li king on 2017/10/26.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK -- 懒加载我们的自定义 view   可以使用闭包的形式实现懒加载
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStateBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
    
        titleView.delegate = self
        return titleView
        
    }()
    // MARK  --  懒加载pageContentView
    private lazy var pageContentView : PageContentView = { [weak self] in
        //确定内容的frame
        let contentH = kScreenH - kStateBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStateBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //确定所有的自控器
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmouseViewController())
        for _ in 0..<1 {
            
            let vc = UIViewController()
            //给 UIColor 扩展   acr4Random 随机生成的是整数，需要在此转为 cgfloat 类型
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, chikdVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    //Mark --系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setUpUI()
//        swiftTest()
    }
}

extension HomeViewController{
    
    private func swiftTest(){
        
        //1 swift 测试
        print("----------------------这是一个swift 的测试")
        let galaxy = "King li "
        print(galaxy.count) //8
        print(galaxy.isEmpty)// false 通过isempty 检测确定值是否为空
        print(galaxy.dropFirst())// "ing li " 删除第一个元素
        print(String(galaxy.reversed()))// " il gnik" 字符串头末倒置 ，返回String类型
        print(galaxy.dropLast()) // king li  删除最后一个元素
        var variableString = "Horse"
        variableString += " and carriage" //使用+号 直接进行字符串的相加
        //print(variableString.characters.count) // Swift3.0写法
        print(variableString.count)            // Swift4.0写法
        // variableString is now "Horse and carriage"
        
        //2 你也可以通过for in 循环访问字符串的单个的Character值
        for character in "Dog!🐶" {
            print(character)
        }
        // D
        // o
        // g
        // !
        // 🐶
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        // Prints "Cat!🐱"

        let linsWithIndentation = """
         this is lne \n\
         thsi is twoline \n\
         this is threeline
         """
        print(linsWithIndentation)

        print("----------------------这是一个swift 的测试")
    }
    private func setUpUI(){
        //不需要系统调整UIScrolView 的内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setUpNavigationBar()
        //添加titleView
        view.addSubview(pageTitleView)
        //添加内容VIEW
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.cyan
        
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

//mark -- 遵守PageTitleViewDelegate
extension HomeViewController :PageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView, selectedIndex Index: Int) {
        
        pageContentView.setCurrentIndex(currentIndex: Index)
    }
    
}
//MARK --遵守PageContentViewDelegate的代理方法
extension HomeViewController:PageContentViewDelegate{
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
