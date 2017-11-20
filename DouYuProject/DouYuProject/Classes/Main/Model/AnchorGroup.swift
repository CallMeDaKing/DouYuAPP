//
//  AnchorGroup.swift
//  DouYuProject
//
//  Created by li king on 2017/11/20.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
@objcMembers
class AnchorGroup: NSObject {
    //该组中对应的房间信息
    //在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
    //在swift4中，编译器不再自动推断，你必须显式添加@objc还有一种更简单的方法，不必一个一个属性的添加,下面这种写法
      var room_list :[[String :NSObject]]?
        //组显示的标题
        var tag_name : String = ""
        //组显示的图标
        var icon_name :String = "home_header_normal"
    
    init(dict:[String:NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
