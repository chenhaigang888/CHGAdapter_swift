//
//  CHGTableViewEmptyDataShow.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit
//import DZNEmptyDataSet
import EmptyDataSet_Swift

public typealias CHGEmptyDataDidTapViewBlock = (_ scrollView: UIScrollView?, _ view: UIView?)->Void
public typealias CHGEmptyDataDidTapButtonBlock = (_ scrollView: UIScrollView?, _ button: UIButton?)->Void

/// 定义没有数据时候的简单显示及操作，如需更多功能可扩展此类以及实现DZNEmptyDataSetSource,DZNEmptyDataSetDelegate中的方法
open class CHGTableViewEmptyDataShow: NSObject {
    
    /// 没有内容时候显示的提示图片
    public var imageName:NSString = ""
    
    /// 没有内容时候显示的提示文本
    public var title:NSString = ""
    
    /// 没有数据提示内容的纵向偏移量
    public var verticalOffset:CGFloat = 0
    
    /// 没有数据的时候是否可以滚动
    public var emptyDataSetShouldAllowScroll:Bool = false
    
    /// 没有数据的时候点击提示内容的回调
    public var emptyDataDidTapViewBlock:CHGEmptyDataDidTapViewBlock?
    
    /// 没有数据的时候点击按钮的回调
    public var emptyDataDidTapButtonBlock:CHGEmptyDataDidTapButtonBlock?
    
}

extension CHGTableViewEmptyDataShow :EmptyDataSetSource {
    open func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let s = NSMutableAttributedString.init(string: self.title as String)
        s.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: self.title.length))
        return s;
    }
    
    open func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage.init(named: self.imageName as String)
    }
    
    open func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return self.verticalOffset
    }
}

extension CHGTableViewEmptyDataShow : EmptyDataSetDelegate {
    open func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        if (self.emptyDataDidTapViewBlock != nil) {
            self.emptyDataDidTapViewBlock!(scrollView,view)
        }
    }
    
    open func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        if (self.emptyDataDidTapButtonBlock != nil) {
            self.emptyDataDidTapButtonBlock!(scrollView,button)
        }
    }
    
    open func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return self.emptyDataSetShouldAllowScroll
    }
    
}
