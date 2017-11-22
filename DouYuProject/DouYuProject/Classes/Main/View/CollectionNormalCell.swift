//
//  CollectionNormalCell.swift
//  DouYuProject
//
//  Created by li king on 2017/11/17.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionViewBaseCell {
    
    //MARK --  控件的属性
    @IBOutlet weak var room_label: UILabel!
    //MARK -- 定义模型属性
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            //房间名称
            room_label.text = anchor?.room_name
        }
    }
}
