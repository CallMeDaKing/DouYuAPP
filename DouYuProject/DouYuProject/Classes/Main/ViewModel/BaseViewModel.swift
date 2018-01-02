//
//  BaseViewModel.swift
//  DouYuProject
//
//  Created by li king on 2018/1/2.
//  Copyright © 2018年 li king. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
}
extension BaseViewModel{
    func loadAnchorData(URLString: String, parameters:[String : Any]? = nil,finishedCallback:@escaping()->()){
        NetWorkTools.requestData(type: .GET, URLString: URLString, parameters: parameters as? [String : NSString]) { (result) in
            //1.对结果进行处理  将any 类型转为字典类型
            guard let resultDict = result as? [String: Any] else{return}
            guard let dataArray = resultDict["data"] as? [[String :Any]] else { return}
            //2.遍历数组中的字典
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            //3.完成回调
            finishedCallback()
        }
    }
}
