//
//  UIBarButtonItem-Extension.swift
//  DouYuProject
//
//  Created by li king on 2017/10/27.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

//对系统类做扩展
extension UIBarButtonItem{
    
    //1 扩展类方法
    
    /*class func creatItem(imageName :String, highLightImageLName:String ,size:CGSize) ->UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highLightImageLName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView:btn)
    }
    */
    //2  使用 便利构造函数  swift 中大多都使用这种构造函数 --> 1 convenience 开头  ，2 在函数中必须使用一个设计构造函数 （self）
    //为了解决有些参数不传 swift 可以给一个默认值 在类型后main加上 =“” 或者zero即可
    convenience init(imageName :String, highLightImageLName:String = "" ,size:CGSize = CGSize.zero){
        //创建button
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        if(highLightImageLName != ""){
        btn.setImage(UIImage(named:highLightImageLName), for: .highlighted)
        }
        
        if(size == CGSize.zero){
            
            btn.sizeToFit()
        }else{
            
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
