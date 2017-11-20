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
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
