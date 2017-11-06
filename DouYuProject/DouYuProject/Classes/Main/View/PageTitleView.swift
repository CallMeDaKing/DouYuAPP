//
//  PageTitleView.swift
//  DouYuProject
//
//  Created by li king on 2017/10/27.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

private let kscrollLineH :CGFloat = 2

class PageTitleView: UIView {
    
    //MARK:- 懒加载

    private lazy var titleLables :[UILabel] = [UILabel]() //懒加载数组存放创建的lable
    private lazy var scrollView:UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        //   scrollView.isPagingEnabled = false  //默认是弄
        scrollView.bounces = false
        
        return scrollView
    }()
    
    //底部滚动线
    private lazy var scrollLine :UIView = {
        
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
        
    }()
    
    
    //MARK:- 定义属性
    private var titles :[String]
    
    //MARK: -自定义构造函数  对view 进行封装  显示内容需要外界传入  必须重写后面的init?(coder aDecoder: NSCoder)函数
     init(frame: CGRect ,titles:[String]) {
        
        self.titles = titles
        
        super.init(frame:frame)
        
        //设置界面
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension  PageTitleView{
    
    private func setUpUI(){
        
        //1 。添加 ScrollView
        
        addSubview(scrollView)
        
        scrollView.frame = bounds
        
        //2. 添加对应的title
        setUpTitleLables()
        
        //3 . 设置底线和滚动滑块
        setBottomMenueAndScrollLine()
        
    }
    
    private func setUpTitleLables(){
        //0.确定lable 的一些frame值
        let lableW :CGFloat = frame.width/CGFloat(titles.count)
        let lableH :CGFloat = frame.height - kscrollLineH
        let lableY :CGFloat = 0
        //1  这种遍历 既可以拿到下标，也可以拿到title
        for(index,title) in titles.enumerated(){
            
            //创建UILable
            let lable = UILabel()
            
            //设置lable 的属性
            
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            // 设置lable 的frame
            let lableX :CGFloat = lableW * CGFloat(index)
            
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            
            scrollView.addSubview(lable)
            titleLables.append(lable)
        }
    }
    
    private func setBottomMenueAndScrollLine(){
        
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加底部scrollLine  滚动的线
        //获取第一个lable
        guard let firstLable = titleLables.first else{return}
        
        firstLable.textColor = UIColor.orange
        scrollView .addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - kscrollLineH, width: firstLable.frame.width, height: kscrollLineH)
        
    }
}
