//
//  RecommendViewModel.swift
//  DouYuProject
//
//  Created by li king on 2017/11/20.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class RecommendViewModel {  //如果用不到kvc 等属性的时候可以不继承NSObject
    //MARK -- 懒加载数组的属性，存放所有的组
    private lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    
}
//MARK --发送网络请求
extension RecommendViewModel{
    
    //推荐页面一共需要请求3个接口
    func requestDatas(){
        //1 .请求推荐数据
        
        //2.请求第二部分的颜值数据
        
        //3.请求后面的游戏的数据
        //获取当前时间秒钟
        
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4$offset=0&time1474252024
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4" ,"offset":"0" ,"time":NSDate.getCurrentTime() as NSString]) { (result) in
            print(result)
            //1. 将result 转成字典类型  现在是anyobject类型
           guard let resultDict = result as? [String : NSObject] else{return}
            //2 .根据data 的key 获取数组   数组里面存放的是一个字典类型
            guard let ArrayData = resultDict["data"] as?[[String :NSObject]] else{return}
            //遍历数组，获取字典，并将字典转成模型对象
            for dict in ArrayData{
                //目前在swift 还没有比较好的第三方框架直接字典转模型，随着这里使用原始的kvc转换方法
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            print(self.anchorGroups)
            for group in  self.anchorGroups{
                
                print("-----",group.tag_name)
            }
            
        }
    }
}
