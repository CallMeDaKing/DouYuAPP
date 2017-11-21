//
//  RecommendViewController.swift
//  DouYuProject
//
//  Created by li king on 2017/11/17.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

//MARK --自定义常量
private let kItemMargin :CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kItemH = kItemW * 3/4
private let kPrettyH = kItemW * 4/3
private let KHeaderViewH :CGFloat = 50
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "PrettyCellID"

class RecommendViewController: UIViewController {
    //MARK -- 懒加载属性
    private lazy var recommenVM : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = { [unowned   self] in
        //1 创建布局
        let flowLayout = UICollectionViewFlowLayout()
        //县默认写死
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = kItemMargin
        //设置组头
        flowLayout.headerReferenceSize = CGSize(width: kScreenW, height: KHeaderViewH)
        //给layout 设置内边距 让两边距离屏幕为10  ，否则会两边填充屏幕，中间空出边距，导致中间边距为30 两边为0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2 创建collectionView 
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStateBarH - kNavigationBarH - kTabBarH - 40), collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册cell
//       collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //注册xib 自定义cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
         collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //注册组头 xib 自定义cell
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:                        UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)    这个是注册最普通的cell
        //collectionview 宽高随着父控件的拉伸和缩小   ！！！！！！  使用与collectionview frame  和父控件 大小不一致的时候
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置界面
        setUpUI()
        //发送网络请求
        loadDat()
    }

}
extension RecommendViewController{
    
    private func setUpUI(){
        view.addSubview(collectionView)
    }
}

//MARK --请求数据
extension  RecommendViewController{
    private func loadDat(){
        recommenVM.requestDatas {
            self.collectionView .reloadData()
        }
    }
}
//mark --遵守代理实现代理方法
extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    //UICollectionViewDelegateFlowLayout  是集继承自UIcollectionViewDelegate  里面有针对item的代理方法
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyH)
        }
        return CGSize(width: kItemW, height: kItemH)
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommenVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            let group = recommenVM.anchorGroups[section]
            return group.anchors.count
        
    }
    
    func  collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        let group = recommenVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //1获取cell
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            
            return cell
        }else{
            
           let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //取出sectionview的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        //取出模型赋值
        headerView.group = recommenVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

