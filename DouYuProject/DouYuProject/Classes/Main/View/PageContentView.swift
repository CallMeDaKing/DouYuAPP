//
//  PageContentView.swift
//  DouYuProject
//
//  Created by li king on 2017/11/6.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
private let cellID = "cellID"

class PageContentView: UIView {
    //MARK - 自定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    //MARK  -- 懒加载属性
    private lazy var collectionView : UICollectionView = { [weak self] in
        //1 创建layout 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    //自定义构造函数  区别开便利构造函数
    init(frame: CGRect , chikdVcs : [UIViewController], parentViewController :UIViewController?) {
        
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
            
            parentViewController?.addChildViewController(childVc)
        }
        //2.添加UICollectionView ,用于在cell 中存放控制器的View,在这用到collectionview ,懒加载
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}

extension PageContentView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        //因为cell 会重复利用，导致可能往contentview添加多次view 针对cell 做的相关优化
        for view in cell.contentView.subviews{
            
            view .removeFromSuperview()
        }
        cell.contentView.addSubview(childVcs[indexPath.item].view)
        
        return cell
    }
}
//MARK-- 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int){
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
    
}
