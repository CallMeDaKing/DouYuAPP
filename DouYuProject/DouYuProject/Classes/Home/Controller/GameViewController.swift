//
//  GameViewController.swift
//  DouYuProject
//
//  Created by li king on 2017/12/18.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kitemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH :CGFloat = 50
private let kGameCellID = "kGameCellID"
private let kGameHeaderID = "kGameHeaderID"

class GameViewController: UIViewController {
    //Mark:懒加载属性
    private lazy var gameVM : GameViewModel = GameViewModel()
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kitemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        //设置头部宽高
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //注册cell
        collectionView.register(UINib(nibName: "recommendGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //注册header
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderID)
        //设置代理
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
    }()
    //Mark:系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        

    }
}
//Mark: 设置UI界面
extension GameViewController{
    private func setupUI(){
        view.addSubview(collectionView)
        loadData()
    }
}
//Mark:请求数据
extension GameViewController{
    private func loadData(){
        gameVM.loadAllGamesData {
            self.collectionView.reloadData()
        }
    }
}
//Mark: 遵守UIcollectionView的数据源协议
extension GameViewController :UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! recommendGameCell
        
        cell.baseGame =  gameVM.games[indexPath.item]
        return cell
    }
//Mark: 设置头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出headerview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeaderID, for: indexPath) as!CollectionHeaderView
        
        headerView.titleLabel.text = "全部"
        headerView.iconImage.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}

