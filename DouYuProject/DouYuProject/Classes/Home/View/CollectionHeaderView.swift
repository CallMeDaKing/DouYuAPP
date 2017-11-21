//
//  CollectionHeaderView.swift
//  DouYuProject
//
//  Created by li king on 2017/11/17.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    //MARK -- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    var group :AnchorGroup?{
        
        didSet{
            titleLabel.text = group?.tag_name
            iconImage.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
