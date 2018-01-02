//
//  AmouseVM.swift
//  DouYuProject
//
//  Created by li king on 2018/1/2.
//  Copyright © 2018年 li king. All rights reserved.
//

import UIKit

class AmouseVM :BaseViewModel {
    
}
extension AmouseVM{
    //
    func loadAmouseData(finishedCallback :@escaping () -> ()){
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
