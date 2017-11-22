//
//  PageTitleView.swift
//  DouYuProject
//
//  Created by li king on 2017/10/27.
//  Copyright © 2017年 li king. All rights reserved.
//

import UIKit

// class 表示我们的协议只能被类遵守， 不写的话可能会被结构体遵守，也可能被枚举遵守 传出一个Int类型
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView:PageTitleView, selectedIndex  Index :Int)
}
//自动定义常量
private let kscrollLineH :CGFloat = 2
private let kNormalColor :(CGFloat ,CGFloat ,CGFloat) = (85,85,85)
private let kSelectorColor:(CGFloat ,CGFloat ,CGFloat) = (255 , 128, 0)
//定义类
class PageTitleView: UIView {
    
    //MARK -- 自定义属性
    private var currentIndex : Int = 0
    private var titles :[String]
    weak var delegate:PageTitleViewDelegate? //表示设置这个属性，必须遵守后面的协议 weak修饰可选
    //
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
            
            //2设置lable 的属性
            
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            
            //3 设置lable 的frame
            let lableX :CGFloat = lableW * CGFloat(index)
            
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            // 4 将label添加到scrollview中
            scrollView.addSubview(lable)
            titleLables.append(lable)
            
            //5 给labe添加手势
            lable.isUserInteractionEnabled = true
            let tapGues = UITapGestureRecognizer(target: self, action: #selector(self.titLabelClick(tapGues:)))
            lable.addGestureRecognizer(tapGues)
            
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
        
        firstLable.textColor = UIColor(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
        scrollView .addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - kscrollLineH, width: firstLable.frame.width, height: kscrollLineH)
        
    }
}
//MARK --  监听label 点击事件
extension PageTitleView {
    
    @objc private func titLabelClick(tapGues:UITapGestureRecognizer){
        
        //0获取当前label 的下标
        guard let  currentLabel = tapGues.view as? UILabel  else {
            return
        }
        //1.如果重复点击label 直接返回。防止多次
        if currentLabel.tag == currentIndex{return}
        
        //2 获取之前的label
        let oldLabel = titleLables[currentIndex]
        //3 保存最新label的下标
        currentIndex = currentLabel.tag
        
        //4 切换文字颜色
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
        //5 文字下滑线滚动
        let scrollLinX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
//MARK -- 对外暴露的方法
extension PageTitleView{
    
    func setTitleWithProgress(progress: CGFloat , sourceIndex:Int ,targetIndex :Int){
        //1.取出sourceLabel  和targertLabel
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        
        //2. 处理滑块逻辑
        let moveTototalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = progress * moveTototalX
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3处理颜色渐变范围
        let colorDelta = (kSelectorColor.0 - kNormalColor.0 ,kSelectorColor.1 - kNormalColor.1 ,kSelectorColor.2 - kNormalColor.2 )
        
        //变化sourceLabel 颜色
        sourceLabel.textColor = UIColor(r: kSelectorColor.0 - colorDelta.0 * progress, g: kSelectorColor.1 - colorDelta.1 * progress, b: kSelectorColor.2 - colorDelta.2 * progress)
        //变化targetlabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4 .记录最新的targetIndex
        currentIndex = targetIndex
        
        
    }
}
