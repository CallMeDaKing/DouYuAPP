//
//  PageContentView.swift
//  DouYuProject
//
//  Created by li king on 2017/11/6.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView:PageContentView , progress: CGFloat , sourceIndex :Int ,targetIndex :Int)
}

private let cellID = "cellID"

class PageContentView: UIView {
    //MARK - 自定义属性
    
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX :CGFloat = 0
    weak var delegate : PageContentViewDelegate?
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
        collectionView.delegate = self
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
//MARK -- 遵守UIcollectionViewDelegate
extension  PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1 定义获取需要的数据
        var progress :CGFloat = 0
        var sourceIndex :Int = 0
        var targetIndex :Int = 0
        
        //2.根据和scrollview 的偏移量进行比教判断是左滑还是右滑
        let currentOffset = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if  currentOffset > startOffsetX {
            //左滑动 比例
            // 计算progress   在这有个只是点， floor 函数 是取整函数
            progress = currentOffset/scrollViewW - floor(currentOffset/scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOffset/scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //如果完全滑动过去  progress 应该为1
            if currentOffset - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑动
            progress = 1 - (currentOffset/scrollViewW - floor(currentOffset/scrollViewW))
            //计算targetIndex
            targetIndex = Int(currentOffset/scrollViewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            //如果完全滑动过去
            if startOffsetX - currentOffset == scrollViewW {
                
                sourceIndex = targetIndex
            }
            
        }
        //3 .将progress /sourceIndex/ targetIndex 传递给titleView
        print("progress:\(progress)  sourceIndex \(sourceIndex) targetIndex \(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
