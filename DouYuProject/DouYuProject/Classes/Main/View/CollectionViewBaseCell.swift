//
//  CollectionViewBaseCell.swift
//  DouYuProject
//
//  Created by li king on 2017/11/22.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickname: UILabel!
    
    //MARK -- 定义房间模型属性
    var anchor : AnchorModel?{

    didSet{
    //0校验是否优质
    guard let anchor = anchor else{return}
    //1取出在线人数显示的文字
    var onlineStr : String = ""
    if anchor.online >= 10000 {
    onlineStr = "\(Int(anchor.online / 10000))在线"
    }else{
    onlineStr = "\(anchor.online)在线"
    }
    onlineBtn.setTitle(onlineStr, for: .normal)
    //2 .显示昵称
    nickname.text = anchor.nickname
    //3.显示封面图片 (oc 经常是使用 sd_webimage) 在swift中我们使用喵神的 Kingfisher 和sd 的使用方式基本一样的
    
    guard let iconUrl = URL(string: anchor.vertical_src) else {return}
    //            sourceImage.kf.setImage(with: iconUrl as? Resource)
    iconImageView.kf.setImage(with: iconUrl)
    }
  }
}
