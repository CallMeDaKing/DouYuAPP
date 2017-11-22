//
//  RecommendCycleView.swift
//  DouYuProject
//
//  Created by li king on 2017/11/22.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

private let cycleCellID = "cycleCellID"

class RecommendCycleView: UIView {
    //mark -- 定义属性
    var cycleModels :[CycleModel]?{
        didSet{
            //1 刷新collectionview
            collectionView.reloadData()
            //2 .设置pagecontrol 的个数
            pageController.numberOfPages = cycleModels?.count ?? 0
        }
    }
    //空间属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    //在swift 4.0 中 autorizingMark 默认是不随这父控件的拉伸而拉伸的，所以不再使用 autoresizingMask = .None
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCellID)
        
    }
    //因为在awakeFromNib() 中拿到的高度并不是我们外面设置的高度，而是cell的高度 ， 但cell 的frame 小和我们设想的frame是不一样的， 有内边距，所以我们在最好在layoutSubviews() 拿到的尺寸永远是正确的，所以设置layout 在下面方法中设置
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collecitonViewflowLayout
        let  layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0;
//        layout.scrollDirection = .horizontal  这是那个属性可以在xib中设置
         collectionView.isPagingEnabled = true
    }
}
//MARK -- 提供一个快速创建View 的方法
extension RecommendCycleView{
    class func recommendCycleView() ->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//MARK -- 遵守UIcollectionView的协议实现代理方法
extension RecommendCycleView :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    }

}
//MARK -- 遵守UIcollectionView代理协议
extension RecommendCycleView :UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1、获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x  //+ scrollView.bounds.width * 0.5  如果想实现滚动到一半，pagecontroll自动 滚动到下一个，可以在 offseX +scrollView.bounds.width * 0.5 就可以了
        
        //2.计算pageController currentIndex
        pageController.currentPage = Int(offsetX / scrollView.bounds.width)
        
    }
    
}
