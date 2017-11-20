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
      recommenVM.requestDatas()
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            if section == 0{
                return 8
            }
            return 4
    }
    
    func  collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1获取cell
        var cell = UICollectionViewCell()
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //取出sectionview的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        return headerView
    }
}

