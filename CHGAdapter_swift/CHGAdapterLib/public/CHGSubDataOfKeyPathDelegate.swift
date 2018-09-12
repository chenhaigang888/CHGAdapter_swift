//
//  CHGSubDataOfKeyPathDelegate.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import Foundation
import UIKit

/// 通过keyPath返回内容
public protocol CHGSubDataOfKeyPathDelegate {
    
    /// 如果你的cell的数据是Model中的某一个字段（比如好友列表 外层Model是Group，Group中有一个字段friends为数组，你想使用Group中的friends字段的元素作为cell，则可以通过这个方法返回:\Group.friends）
    ///
    /// - Parameters:
    ///   - indexPath: 当前的位置
    ///   - targetView: 当前内容所在的View 一般为UITableView和UICollectionView
    /// - Returns: 返回keyPath
    func subDataKeyPath(_ indexPath:IndexPath, targetView:UIScrollView ) -> Any?
}
