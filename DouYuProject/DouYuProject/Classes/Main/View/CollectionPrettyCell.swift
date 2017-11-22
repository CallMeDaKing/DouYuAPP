//
//  CollectionPrettyCell.swift
//  DouYuProject
//
//  Created by li king on 2017/11/17.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionViewBaseCell {
    //MARK --  拿到控件的属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK -- 定义模型属性
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            //3.显示所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
    }
}
