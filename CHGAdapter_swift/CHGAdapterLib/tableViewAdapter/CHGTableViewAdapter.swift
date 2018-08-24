//
//  CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 回调
public typealias CHGCallBack = (_ data:AnyObject?) -> Void

/// 事件传输block target.
/// - Parameters:
///   - target: 当前事件发生的场所（一般是cell、header、footer、adapter中）
///   - params: 事件发生的场所传递出来的参数
///   - tag: 区分事件发生的场所中的多个事件
///   - callBack: 当当前类中处理完事件后异步通知事件所发生的场所
/// - Returns: 当当前类中处理完事件后同步步通知事件所发生的场所
public typealias CHGEventTransmissionBlock = (_ target:AnyObject,_ params:AnyObject,_ tag:NSInteger,_ callBack:CHGCallBack?) ->AnyObject?

/// tableViewDidSelectRow 回调
public typealias CHGTableViewDidSelectRowBlock = (_ tableView:UITableView,_ indexPath:IndexPath,_ itemData:AnyObject)->Void

public protocol CHGTableViewAdapterProtocol:UITableViewDelegate,UITableViewDataSource {
    
    func obtainCellNameWithCell(_ data:AnyObject ,tableView:UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> NSString
    
    func obtainHeaderNameWithHeader(_ data:AnyObject,tableView:UITableView, viewForHeaderInSection section:NSInteger) -> NSString
    
    func obtainFooterNameWithFooter(_ data:AnyObject,tableView:UITableView, viewForFooterInSection section:NSInteger) -> NSString
}

open class CHGTableViewAdapter: NSObject,CHGTableViewAdapterProtocol {
    
    public var cellName:NSString? = ""
    public var headerName:NSString? = ""
    public var footerName:NSString? = ""
    
    /// 如果cell、headerView、footerView的高度都统一可以通过直接设置以下参数进行设置
    public var cellHeight:CGFloat = 44
    public var headerHeight:CGFloat = 0.01
    public var footerHeight:CGFloat = 0.01
    
    public var adapterData:CHGTableViewAdapterData = CHGTableViewAdapterData.init()
    public var rowsOfSectionKeyName:Any?
    public var tableViewDeselectRowAtIndexPathAnimation:Bool = true
    public var tag:NSInteger = 0
    public var controller:UIViewController?
    
    
    open func obtainCellNameWithCell(_ data: AnyObject, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> NSString {
        return self.cellName!;
    }
    
    open func obtainHeaderNameWithHeader(_ data: AnyObject, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> NSString {
        return self.headerName!;
    }
    
    open func obtainFooterNameWithFooter(_ data: AnyObject, tableView: UITableView, viewForFooterInSection section: NSInteger) -> NSString {
        return self.footerName!;
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.footerHeight
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        let cellDatas = self.adapterData.cellDatas
        if cellDatas == nil || cellDatas?.count == 0 {
            return 0
        }
        return (cellDatas?.count)!
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellDatas = self.adapterData.cellDatas
        if cellDatas?.count == 0 {
            return 0;
        }
        if (self.rowsOfSectionKeyName != nil && (!(cellDatas![section] is NSArray))) {
            if rowsOfSectionKeyName is String || rowsOfSectionKeyName is NSString {
                return ((cellDatas![section] as AnyObject).value(forKey: self.rowsOfSectionKeyName! as! String) as! NSArray).count
            } else {
                return (cellDatas![section][keyPath:rowsOfSectionKeyName as! AnyKeyPath] as! NSArray).count
            }
        }
        let cellData = cellDatas![section]
        if cellData is NSArray {
            return (cellData as AnyObject).count
        } else {
            return 1
        }
    }
    
    open func cellDataWithIndexPath(_ indexPath:IndexPath) -> AnyObject? {
        if self.adapterData.cellDatas?.count == 0 {
            return nil
        }
        let sectionData:AnyObject = self.adapterData.cellDatas![indexPath.section] as AnyObject
        if self.rowsOfSectionKeyName != nil && !(sectionData is NSArray) {
            var tempArray:NSArray = []
            if rowsOfSectionKeyName is String || rowsOfSectionKeyName is NSString {
                tempArray = sectionData.value(forKey: rowsOfSectionKeyName as! String) as! NSArray
            } else {
                tempArray = sectionData[keyPath:rowsOfSectionKeyName as! AnyKeyPath] as! NSArray
            }
            return tempArray[indexPath.row] as AnyObject
        } else {
            return sectionData is NSArray ? (sectionData as! NSArray)[indexPath.row] as AnyObject : sectionData as AnyObject
        }
    }
    
    open func fileIsExit(_ fileName:String) -> Bool {
        let xibFile = Bundle.main.path(forResource: fileName, ofType: "nib")
        return xibFile != nil
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath)
        let identifier = self.obtainCellNameWithCell(cellData!, tableView: tableView, cellForRowAtIndexPath: indexPath)
        if identifier.length == 0 {
            return UITableViewCell()
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier as String)
        if cell == nil {
            if self.fileIsExit(identifier as String) {
                tableView.register(UINib (nibName: identifier as String, bundle: nil), forCellReuseIdentifier: identifier as String)
            } else {
                let NameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                let classAllNameClass:AnyClass = NSClassFromString("\(NameSpace).\(identifier)")!
                tableView.register(classAllNameClass, forCellReuseIdentifier: identifier as String)
            }
            cell = tableView.dequeueReusableCell(withIdentifier: identifier as String, for: indexPath)
        }
        let cell_:CHGTableViewCell = cell as! CHGTableViewCell
        cell_.eventTransmissionBlock = tableView.eventTransmissionBlock
        cell_.cellForRow(atIndexPath: indexPath, tableView: tableView, data: cellData)
        return cell_
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGTableViewHeaderFooterViewType.HeaderType, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGTableViewHeaderFooterViewType.FooterType, viewForHeaderInSection: section)
    }
    
    open func headerFooterDataWithType(type:CHGTableViewHeaderFooterViewType,section:NSInteger) -> AnyObject? {
        let headerFooterDatas:NSArray? =
            type == CHGTableViewHeaderFooterViewType.HeaderType
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas
        if headerFooterDatas != nil && headerFooterDatas?.count != 0 {
            if section >= (headerFooterDatas?.count)! {
                return nil
            }
            return headerFooterDatas?[section] as AnyObject
        }
        return nil
    }
    
    open func tableview(_ tableView:UITableView,tableViewHeaderFooterViewType type:CHGTableViewHeaderFooterViewType,viewForHeaderInSection section:NSInteger) -> UIView? {
        //获取headerFooter的Item 数据
        let headerFooterData:AnyObject? = self.headerFooterDataWithType(type: type, section: section)
        if headerFooterData == nil {
            return nil
        }
        let identifier:NSString =
            type == CHGTableViewHeaderFooterViewType.HeaderType ? self.obtainHeaderNameWithHeader(headerFooterData!, tableView: tableView, viewForHeaderInSection: section)
                :
                self.obtainFooterNameWithFooter(headerFooterData!, tableView: tableView, viewForFooterInSection: section)
        
        if identifier.length == 0 {
            return nil
        }
        
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier as String)
        if view == nil {
            if self.fileIsExit(identifier as String) {
                tableView.register(UINib(nibName: identifier as String, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier as String)
            } else {
                let NameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                let classAllNameClass:AnyClass = NSClassFromString("\(NameSpace).\(identifier)")!
                tableView.register(classAllNameClass, forHeaderFooterViewReuseIdentifier: identifier as String)
            }
            view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier as String)
        }
        
        let view_:CHGTableViewHeaderFooterView = view as! CHGTableViewHeaderFooterView
        view_.eventTransmissionBlock = tableView.eventTransmissionBlock
        view_.headerFooter(headerFooterForSection: section, tableView: tableView, data: headerFooterData!, type: type)
        return view_
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            (view as! CHGTableViewHeaderFooterView).headerFooterViewWillAppearWithType(type: CHGTableViewHeaderFooterViewType.HeaderType)
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CHGTableViewCell {
            (cell as! CHGTableViewCell).cellWillAppear()
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            (view as! CHGTableViewHeaderFooterView).headerFooterViewWillAppearWithType(type: CHGTableViewHeaderFooterViewType.FooterType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            (view as! CHGTableViewHeaderFooterView).headerFooterViewDidDisAppearWithType(type: CHGTableViewHeaderFooterViewType.HeaderType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CHGTableViewCell {
            (cell as! CHGTableViewCell).cellDidDisappear()
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            (view as! CHGTableViewHeaderFooterView).headerFooterViewDidDisAppearWithType(type: CHGTableViewHeaderFooterViewType.FooterType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: self.tableViewDeselectRowAtIndexPathAnimation)
        if tableView.tableViewDidSelectRowBlock != nil {
            tableView.tableViewDidSelectRowBlock!(tableView,indexPath,self.cellDataWithIndexPath(indexPath)!)
        }
    }
}

