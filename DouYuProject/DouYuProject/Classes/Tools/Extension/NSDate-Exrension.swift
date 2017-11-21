//
//  NSDate-Exrension.swift
//  DouYuProject
//
//  Created by li king on 2017/11/20.
//  Copyright © 2017年 li king. All rights reserved.
//

import Foundation
extension NSDate{
    class func getCurrentTime() -> String{
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)   //如果字符串强转Int 是可选类型，需要强制解包，如果是double 类型，则可以直接进行强转为Int类型。
        return "\(interval)"
    }
}
