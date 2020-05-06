//
//  CHGViewPropertyProtocol.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/5/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

/// View属性协议
public protocol CHGViewPropertyProtocol {
    
    ///当前数据可通过此block向外部传递
    var eventTransmissionBlock:CHGEventTransmissionBlock? { get set }
    ///当前所在的父view。cell的父view为tableView、collectionView。
    var targetView:UIView? { get set }
    ///当前cell、headerFooter、view需要显示的数据
    var model:Any? { get set }
    ///根据类型不一样存储不同的协议
    var protocols:[Any]? { get set }
    
    
}

/// cell的生命周期协议
public protocol CHGViewLifeCycleProtocol : CHGViewPropertyProtocol {
    
    ///当前cell的indexPath信息
    var indexPath:IndexPath? { get set }
    
    /// 必须重写这个方法 子类应该在这个方法中给cell中的各个view设定value
    /// - Parameters:
    ///   - indexPath: 当前cell在UITableView中的位置
    ///   - targetView: 当前cell所在的UITableView、UICollectionView
    ///   - model: 当前Cell的数据
    func cellForRowAt(indexPath:IndexPath, targetView:UIView, model:Any, eventTransmissionBlock:CHGEventTransmissionBlock?) -> Void
    
    /// 将被复用
    /// - Parameter identifier: 复用标志
    func cellWillReuse(with identifier:String) -> Void
    
    func cellWillReuse(with identifier:String, indexPath:IndexPath) -> Void
    
    /// cell将要显示
    func cellWillAppear() -> Void
    
    /// cell已经消失
    func cellDidDisappear() -> Void
}


/// TableViewHeaderFooter生命周期协议
public protocol CHGTableViewHeaderFooterLifeCycleProtocol : CHGViewPropertyProtocol {
    
    var section:Int? { get set }
    var type:CHGTableViewHeaderFooterViewType? { get set }
    
    
    /// 必须重写这个方法 子类应该在这个方法中给HeaderFooterView中的各个view设定value
    /// - Parameters:
    ///   - section: 当前HeaderFooterView在UITableView中的位置
    ///   - tableView: 当前HeaderFooterView所在的UITableView
    ///   - model: 当前HeaderFooterView的数据
    ///   - type: 当前类型是header或者footer
    func headerFooter(for section:Int, in tableView:UITableView, model:Any, type:CHGTableViewHeaderFooterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) -> Void
    
    /// 将要复用
    /// - Parameter identifier: 复用标志
    func headerFooterViewWillReuse(with identifier:String) -> Void
    
    /// headerFooterView将要显示
    /// - Parameter type: 类型
    func headerFooterViewWillAppear(with type:CHGTableViewHeaderFooterViewType) -> Void
    
    /// headerFooterView已经消失
    /// - Parameter type: 类型
    func headerFooterViewDidDisAppear(with type:CHGTableViewHeaderFooterViewType) -> Void
    
    
}



public protocol CHGCollectionReusableViewLifeCycleProtocol : CHGViewPropertyProtocol {
    var indexPath:IndexPath? { get set }
    var kind:String? { get set }
    
    /// reusableView数据
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: reusableView所在的indexPath
    ///   - kind: kind
    ///   - model: model 数据
    func reusableView(for collectionView:UICollectionView, indexPath:IndexPath, kind:String, model:Any, eventTransmissionBlock:CHGEventTransmissionBlock?) -> Void
    
    /// 将被复用
    /// - Parameters:
    ///   - identifier: identifier description
    ///   - indexPath: indexPath description
    func reusableViewWillReuse(with identifier:String, indexPath:IndexPath) -> Void
    
    func reusableViewWillAppear() -> Void
    
    func reusableViewDidDisappear() -> Void
}
