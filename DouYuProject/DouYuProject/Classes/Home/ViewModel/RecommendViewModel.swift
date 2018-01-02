//
//  RecommendViewModel.swift
//  DouYuProject
//
//  Created by li king on 2017/11/20.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class RecommendViewModel :BaseViewModel{  //如果用不到kvc 等属性的时候可以不继承NSObject
    //MARK -- 懒加载数组的属性，存放所有的组
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    private lazy var bigDataGroup:AnchorGroup = AnchorGroup()
    private lazy var prettyGroup :AnchorGroup = AnchorGroup()
}
//MARK --发送推荐模块网络请求
extension RecommendViewModel{
    //推荐页面一共需要请求3个接口
    func requestDatas(finishCallBack :@escaping () ->()){
        //0定义参数
        let parameters = ["limit":"4" ,"offset":"0" , "time": NSDate.getCurrentTime() as NSString]
        //创建Group  现在3（2-12）部分的数据都已经存储到anchorGroups ，因为我们对外的暴露的数据原是anchorGroups  所以需要将三个请求的数据全部放到anchorGroups 中， 因为数据请求是异步这就有个个先后问题，所以我们在这需要创建一个队列
        let Dgroup = DispatchGroup()
        //1 .请求推荐数据
            //加入组
            Dgroup.enter()
            NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            //做校验看看有没有值然后将他转为字典类型，现在是anyobject类型
            guard let resultDict = result as? [String : NSObject] else{return}
            //通过键data  , 获取到字典中的的值是个数组类型， 数组中放的又是data 类型
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{return}
            //遍历字典
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //需要先将字典转为模型
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //离开组
            Dgroup.leave()
        }
        //2.请求第二部分的颜值数据
        Dgroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //香江result 现在是anyObject 类型， 先转为字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            //根据data key 来取出字典中的值是个数组， 数组中存放的又是字典类型
            guard let dataArray = resultDict["data"] as? [[String :NSObject]] else {return}
            //遍历数组将数据进行解析将字典再转为模型对象
            //2.1 设置租的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            Dgroup.leave()
        }
        //3.请求2-12后面的游戏的数据
        //获取当前时间秒钟   转成字符串  "\(internal)"
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4$offset=0&time1474252024
        Dgroup.enter()
        
        //抽取以后的代码
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            Dgroup.leave()
        }
        //判断所有的数据都请求到 ,然后按顺序插入到anchorGroups 数组中 [bigDataGroup, prettyGroup ,第三部分数据]  ，因为在闭包呢内所以属性加self.
        Dgroup.notify(queue:DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
       
        
    }
    //MARK -- 请求轮播数据 同样通过闭包返回数据
    func requestCycleData(finishCallBack:@escaping () -> ()) {
        NetWorkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version": "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDic = result as? [String :NSObject] else {return }
            guard  let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            //3。字典转模型
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            print(self.cycleModels)
            finishCallBack()
        }
    }
}


