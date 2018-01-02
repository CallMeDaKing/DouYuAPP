//
//  BaseAnchorViewController.swift
//  DouYuProject
//
//  Created by li king on 2018/1/2.
//  Copyright © 2018年 li king. All rights reserved.
//

import UIKit

//MARK --自定义常量
private let kItemMargin :CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kItemH = kItemW * 3/4
private let kPrettyH = kItemW * 4/3
private let KHeaderViewH :CGFloat = 50
private let kCycleViewH :CGFloat = kScreenW * 3/8
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "PrettyCellID"
private let kGameViewH :CGFloat = 90


//Mark:抽取的父类
class BaseAnchorViewController: UIViewController {
    //Mark:定义属性  因为对具体是哪一个viewmodel ,所以在父类就不进行赋值，让子类赋值  但是必须保一定有值，
        var baseVM : BaseViewModel!
    
        lazy var collectionView : UICollectionView = {
        //1. 创建collectionview的flowlayout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: KHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2创建collectionview
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStateBarH - kNavigationBarH - kTabBarH - 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.register(UINib(nibName:"CollectionNormalCell",bundle:nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"CollectionPrettyCell",bundle:nil), forCellWithReuseIdentifier: kPrettyCellID)
        //注册组头
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    //Mark:系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadData()
    }
}
//Mark:设置UI界面
extension BaseAnchorViewController{
    private func setUpUI(){
        view.addSubview(collectionView)
    }
}
//Mark:请求数据  父类有加载数据的方法们但是方法不同，仅做一个空方法，具体有子类去实现
//extension BaseAnchorViewController{
//   internal func loadData(){}
//}
//Mark:遵从数据源和代理协议
extension BaseAnchorViewController:UICollectionViewDataSource ,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count   //返回主笔的个数
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        //2 给cell 设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    //展示头视图数据
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出headerView
        let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        //2 给headerView设置数据
        headerview.group = baseVM.anchorGroups[indexPath.section]
        return headerview
    }
}
