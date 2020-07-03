//
//  CHGViewPropertyProtocol.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/5/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

/// 适配器数据协议
public protocol CHGAdapterDataProtocol {
    var cellDatas:[Any]? { get set }
    var headerDatas:[Any]? { get set }
    var footerDatas:[Any]? { get set }
    var customData:Any? { get set }
}

/// UITableView 适配器数据协议
public protocol CHGTableViewAdapterDataProtocol : CHGAdapterDataProtocol {
    var indexDatas:[String]? { get set }
}

/// 简化获取关键数据的协议
public protocol SimplifiedGetDataProtocol {
    
    func headerDatas() -> [Any]?
    
    func cellData() -> [Any]?
    
    func footerDatas() -> [Any]?
    
    func indexDatas() -> [Any]?
    
    ///  获取AdapterData中的customData
    func customData() -> Any?
    
    /// 返回当前cell所在的controller
    func controller() -> UIViewController?
    
    func adapterData() -> CHGAdapterDataProtocol?
}

/// View属性协议
public protocol CHGViewPropertyProtocol : SimplifiedGetDataProtocol {
    
    ///当前数据可通过此block向外部传递
    var eventTransmissionBlock:CHGEventTransmissionBlock? { get set }
    ///当前所在的父view。cell的父view为tableView、collectionView。
    var targetView:UIView? { get set }
    ///当前cell、headerFooter、view需要显示的数据
    var model:Any? { get set }
//    ///根据类型不一样存储不同的协议
//    var protocols:[Any]? { get set }
    
    var protocolsVMO:[ViewMappingObject]? { get set }
    
    ///当前cell的indexPath信息
    var indexPath:IndexPath? { get set }
    
    var section:Int? { get set }
    
    var type:CHGAdapterViewType? { get set }
    
    var kind:String? { get set }
}

extension CHGViewPropertyProtocol {
    ///  获取AdapterData中的customData
    public func customData() -> Any? {
        return adapterData()?.customData
    }
    
    public func headerDatas() -> [Any]? {
        return adapterData()?.headerDatas
    }
    
    public func cellData() -> [Any]? {
        return adapterData()?.cellDatas
    }
    
    public func footerDatas() -> [Any]? {
        return adapterData()?.footerDatas
    }
    
    public func indexDatas() -> [Any]? {
        guard let adapterData:CHGTableViewAdapterDataProtocol = adapterData() as? CHGTableViewAdapterDataProtocol else { return nil }
        return adapterData.indexDatas
    }
    
    /// 返回当前cell所在的controller
    public func controller() -> UIViewController? {
        if targetView is UITableView {
            guard let tableView:UITableView = targetView as? UITableView else { return nil }
            return tableView.tableViewAdapter?.controller
        }
        
        if targetView is UICollectionView {
            guard let collectionView:UICollectionView = targetView as? UICollectionView else { return nil }
            return collectionView.collectionViewAdapter?.controller
        }
        return nil
    }
    
    public func adapterData() -> CHGAdapterDataProtocol? {
        if targetView is UITableView {
            guard let tableView:UITableView = targetView as? UITableView else { return nil }
            return tableView.adapterData
        }
        
        if targetView is UICollectionView {
            guard let collectionView:UICollectionView = targetView as? UICollectionView else { return nil }
            return collectionView.adapterData
        }
        return nil
    }
}


open class ViewMappingObject: NSObject {
    var view:CHGViewPropertyProtocol?
    var mapping:[CHGAdapterViewType : Any?]?
    
    public init(view:CHGViewPropertyProtocol?, mapping:[CHGAdapterViewType : Any]?) {
        super.init()
        self.view = view
        self.mapping = mapping
    }
    
}


public protocol CHGViewProtocol : CHGViewPropertyProtocol {
    func addAutoDistributionModel(view:CHGViewProtocol, mapping:[CHGAdapterViewType:Any]?) -> Void
    
    func replaceAt(index:Int, autoDistributionModel view:CHGViewProtocol, mapping:[CHGAdapterViewType:Any]?) -> Void
    
    func removeAutoDistributionModelViewAt(index:Int) -> Void
    
    func removeAutoDistributionModelView() -> Void
}


/// cell的生命周期协议
public protocol CHGViewLifeCycleProtocol : CHGViewProtocol{
    
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
public protocol CHGTableViewHeaderFooterLifeCycleProtocol : CHGViewProtocol {
    
    /// 必须重写这个方法 子类应该在这个方法中给HeaderFooterView中的各个view设定value
    /// - Parameters:
    ///   - section: 当前HeaderFooterView在UITableView中的位置
    ///   - tableView: 当前HeaderFooterView所在的UITableView
    ///   - model: 当前HeaderFooterView的数据
    ///   - type: 当前类型是header或者footer
    func headerFooter(for section:Int, in tableView:UITableView, model:Any, type:CHGAdapterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) -> Void
    
    /// 将要复用
    /// - Parameter identifier: 复用标志
    func headerFooterViewWillReuse(with identifier:String) -> Void
    
    /// headerFooterView将要显示
    /// - Parameter type: 类型
    func headerFooterViewWillAppear(with type:CHGAdapterViewType) -> Void
    
    /// headerFooterView已经消失
    /// - Parameter type: 类型
    func headerFooterViewDidDisAppear(with type:CHGAdapterViewType) -> Void
    
}


public protocol CHGCollectionReusableViewLifeCycleProtocol : CHGViewProtocol {
    
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


