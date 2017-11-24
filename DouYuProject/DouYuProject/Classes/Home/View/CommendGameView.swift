//
//  CommendGameView.swift
//  DouYuProject
//
//  Created by li king on 2017/11/24.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

private let gameCellID = "gameCellID"
private let kEdgeInsetMargin :CGFloat = 10
class CommendGameView: UIView {
    //定义数据的属性
    var groups :[AnchorGroup]?{
        didSet{
            //由于数组中的热门和颜值 两项是没有的，我们需要在使用前将数组中的前两组数据删除掉
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加更多组元素
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            //2 .刷新表格
            collectionView.reloadData()
        }
    }
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册cell
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gameCellID)
        //注册nib cell
        collectionView.register(UINib(nibName: "recommendGameCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
        //给collectionVewi 添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}
//MARK -- 提供一个快速创建的类方法
extension CommendGameView {
    
    class  func recommendGameView() -> CommendGameView{
        return Bundle.main.loadNibNamed("CommendGameView", owner: nil, options: nil)?.first as! CommendGameView
    }
}

// MARK -- 遵守UIcolectionViewDataSource 的数据协议
extension  CommendGameView :UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as! recommendGameCell
        //取出group
        cell.group = groups![indexPath.item]
        
        return cell
    }
}
