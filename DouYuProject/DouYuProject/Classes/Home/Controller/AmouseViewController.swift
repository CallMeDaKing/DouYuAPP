//
//  AmouseViewController.swift
//  DouYuProject
//
//  Created by li king on 2018/1/2.
//  Copyright © 2018年 li king. All rights reserved.
//

import UIKit

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "PrettyCellID"

private let kItemMargin :CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kItemH = kItemW * 3/4
private let kPrettyH = kItemW * 4/3
private let KHeaderViewH :CGFloat = 50
private let kCycleViewH :CGFloat = kScreenW * 3/8

class AmouseViewController: BaseAnchorViewController {
    
    //Mark:懒加载属性//Mark:
    private lazy var amouseVM : AmouseVM = AmouseVM()
}

//Mark:请求数据
extension AmouseViewController{
    private func loadData(){
        //1 给父类中viewmodel 赋值
        baseVM = amouseVM
        //2.请求数据
        amouseVM.loadAmouseData {
            self.collectionView.reloadData()
        }
    }
}

