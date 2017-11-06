//
//  PageContentView.swift
//  DouYuProject
//
//  Created by li king on 2017/11/6.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit


class PageContentView: UIView {
    //MARK - 自定义属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    //MARK  -- 懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1 创建layout 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        return collectionView
    }()
    //自定义构造函数  区别开便利构造函数
    init(frame: CGRect , chikdVcs : [UIViewController], parentViewController :UIViewController) {
        
        self.childVcs = chikdVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK -- 设置UI 界面
extension PageContentView{
    
    private func setUpUI(){
        
        //1. 将所有的子控制器，添加到父控制器中
        for childVc in childVcs{
            
            parentViewController.addChildViewController(childVc)
        }
        //2.添加UICollectionView ,用于在cell 中存放控制器的View,在这用到collectionview ,懒加载
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}
