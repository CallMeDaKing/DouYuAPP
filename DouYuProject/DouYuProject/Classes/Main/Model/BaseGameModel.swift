//
//  BaseGameModel.swift
//  DouYuProject
//
//  Created by li king on 2017/12/18.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
@objcMembers 
class BaseGameModel: NSObject {
    //Mark:定义属性
    var tag_name : String = ""
    //添加游戏对应的图标
    var icon_url :String = ""
    //MARK-- 构造函数
    override init() {
    }
    //Mark:自定义构造函数
    init(dict: [String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
