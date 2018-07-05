//
//  CHGTableViewEmptyDataShow.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

open class CHGTableViewEmptyDataShow: NSObject {

    public var imageName:NSString = ""
    public var title:NSString = ""
    public var verticalOffset:CGFloat = 0
    public var emptyDataSetShouldAllowScroll:Bool = false
    
}

extension CHGTableViewEmptyDataShow :DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    open func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: self.imageName as String)
    }
    
    open func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let s = NSMutableAttributedString.init(string: self.title as String)
        s.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: self.title.length))
        return s;
    }
    
    open func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return self.verticalOffset
    }
    
    open func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyDataSetShouldAllowScroll
    }
}
