//
//  CollectionCycleCell.swift
//  DouYuProject
//
//  Created by li king on 2017/11/22.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK -- 定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            titleView.text = cycleModel?.title
            //如果没有数据返回“”
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
