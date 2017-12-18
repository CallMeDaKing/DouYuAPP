//
//  GameViewModel.swift
//  DouYuProject
//
//  Created by li king on 2017/12/18.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

class GameViewModel{
    lazy var games :[GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadAllGamesData(finishedCallback : @escaping () ->()){
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName": "game"]) { (result) in
            //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game&page=100
            //1 获取数据 先从any 类型换为字典类型
            guard let resultDict = result as? [String : Any] else{return}
            //通过键值获取对应 的数组 里面存放的是字典类型
            guard let dataArray = resultDict["data"] as?[[String : Any]] else{return}
            
            //2.字典转模型
            for dict in dataArray{
                //将转化后的模型存入到数组中
                self.games.append(GameModel(dict:dict))
            }
            //完成回调
            finishedCallback()
        }
        
        
    }
}
