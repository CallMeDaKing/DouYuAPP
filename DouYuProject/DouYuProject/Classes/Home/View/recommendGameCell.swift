//
//  recommendGameCell.swift
//  DouYuProject
//
//  Created by li king on 2017/11/24.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
import Kingfisher
class recommendGameCell: UICollectionViewCell {
    //MARK -- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    //自定义模型属性
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            
            let icon_url = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: icon_url, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    //MARK -- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
