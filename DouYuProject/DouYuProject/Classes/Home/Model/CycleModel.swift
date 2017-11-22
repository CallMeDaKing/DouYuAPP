//
//  CycleModel.swift
//  DouYuProject
//
//  Created by li king on 2017/11/22.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
@objcMembers
class CycleModel: NSObject {
    
    //需要有标题
    var title : String = ""
    //图片地址
    var pic_url :String = ""
    //主播信息对应的字典
    var room :[String :NSObject]?{
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播对应的模型信息
    var anchor : AnchorModel?
    //定义构造函数
    init(dict :[String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
}
