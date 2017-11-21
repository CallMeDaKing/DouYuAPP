//
//  AnchorGroup.swift
//  DouYuProject
//
//  Created by li king on 2017/11/20.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit
@objcMembers   //swift4.0中需要显式加上@obj 类型的前缀。 除了这种方法，还可以用另外一种方法，就是在每个变量前加上@obj 。
class AnchorGroup: NSObject {
    //在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
    //在swift4中，编译器不再自动推断，你必须显式添加@objc还有一种更简单的方法，不必一个一个属性的添加,下面这种写法
    
    //该组中对应的房间信息
    var room_list :[[String :NSObject]]? { //数组中存放的是字典类型
        didSet{  //didsSet 监听属性变化  对应的还有willet
            guard let room_list = room_list else {return}
            for dict in room_list{
            anchors.append(AnchorModel(dict:dict))
            }
         }
    }
    
    //组显示的标题
    var tag_name : String = ""
    //组显示的图标
    var icon_name :String = "home_header_normal"
    //定义主播的模型对象数组 来存储主播信息
    lazy var anchors :[AnchorModel] = [AnchorModel]()
    
    //MARK-- 构造函数
    override init() {
        
    }
    
    
    //传入字典转为模型对象
    init(dict:[String:NSObject]){
    super.init()
        setValuesForKeys(dict)
    }
    //有些key没有设置对应的属性，需要重写下面的方法，防止报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
