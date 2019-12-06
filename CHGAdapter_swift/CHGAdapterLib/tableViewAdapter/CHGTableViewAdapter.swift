//
//  CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 回调
public typealias CHGCallBack = (_ data:Any?) -> Void

/// 事件传输block target.
/// - Parameters:
///   - target: 当前事件发生的场所（一般是cell、header、footer、adapter中）
///   - params: 事件发生的场所传递出来的参数
///   - tag: 区分事件发生的场所中的多个事件
///   - callBack: 当当前类中处理完事件后异步通知事件所发生的场所
/// - Returns: 当当前类中处理完事件后同步步通知事件所发生的场所
public typealias CHGEventTransmissionBlock = (_ target:Any?,_ params:Any?,_ tag:NSInteger,_ callBack:CHGCallBack?) ->Any?

/// tableViewDidSelectRow 回调
public typealias CHGTableViewDidSelectRowBlock = (_ tableView:UITableView,_ indexPath:IndexPath,_ itemData:Any)->Void

public protocol CHGTableViewAdapterProtocol:UITableViewDelegate,UITableViewDataSource, CHGSubDataOfKeyPathDelegate{
    
    func obtainCellNameWithCell(_ data:Any ,tableView:UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> String
    
    func obtainHeaderNameWithHeader(_ data:Any,tableView:UITableView, viewForHeaderInSection section:NSInteger) -> String
    
    func obtainFooterNameWithFooter(_ data:Any,tableView:UITableView, viewForFooterInSection section:NSInteger) -> String
}

open class CHGTableViewAdapter: NSObject,CHGTableViewAdapterProtocol {
    
    public var cellName:String? = ""
    public var headerName:String? = ""
    public var footerName:String? = ""
    
    /// 如果cell、headerView、footerView的高度都统一可以通过直接设置以下参数进行设置
    public var cellHeight:CGFloat = 44
    public var headerHeight:CGFloat = 0.01
    public var footerHeight:CGFloat = 0.01
    
    public var adapterData:CHGTableViewAdapterData = CHGTableViewAdapterData.init()
    public var keyPathOfSubData:Any?
    public var tableViewDeselectRowAtIndexPathAnimation:Bool = true
    public var tag:NSInteger = 0
    public var controller:UIViewController?
    
    
    open func obtainCellNameWithCell(_ data: Any, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> String {
        return self.cellName!;
    }
    
    open func obtainHeaderNameWithHeader(_ data: Any, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> String {
        return self.headerName!;
    }
    
    open func obtainFooterNameWithFooter(_ data: Any, tableView: UITableView, viewForFooterInSection section: NSInteger) -> String {
        return self.footerName!;
    }
    
    open func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        return self.keyPathOfSubData
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
        let subDataKeyPathTemp = self.subDataKeyPath(IndexPath.init(row: 0, section: section), targetView: tableView)
        if (subDataKeyPathTemp != nil && (!(cellDatas![section] is NSArray))) {
            if subDataKeyPathTemp is String || subDataKeyPathTemp is NSString {
                if (subDataKeyPathTemp as? NSString)?.length != 0 {
                    return ((cellDatas![section] as AnyObject).value(forKey: subDataKeyPathTemp! as! String) as! NSArray).count
                }
            } else {
                return (cellDatas![section][keyPath:subDataKeyPathTemp as! AnyKeyPath] as! NSArray).count
            }
        }
        let cellData = cellDatas![section]
        if cellData is NSArray {
            return (cellData as AnyObject).count
        } else {
            return 1
        }
    }
    
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.adapterData.indexDatas
    }
    
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
    
    open func cellDataWithIndexPath(_ indexPath:IndexPath,tableView: UITableView) -> Any? {
        if self.adapterData.cellDatas?.count == 0 {
            return nil
        }
        let sectionData = self.adapterData.cellDatas![indexPath.section]
        let subDataKeyPathTemp = self.subDataKeyPath(indexPath,targetView: tableView)
        if subDataKeyPathTemp != nil && !(sectionData is NSArray) {
            var tempArray:NSArray = []
            if subDataKeyPathTemp is String || subDataKeyPathTemp is NSString {
                if (subDataKeyPathTemp as? NSString)?.length != 0 {
                    tempArray = (sectionData as AnyObject).value(forKey: subDataKeyPathTemp as! String) as! NSArray
                }
            } else {
                tempArray = sectionData[keyPath:subDataKeyPathTemp as! AnyKeyPath] as! NSArray
            }
            return tempArray.count == 0 ? sectionData : tempArray[indexPath.row]
        } else {
            return sectionData is NSArray ? (sectionData as! NSArray)[indexPath.row] : sectionData
        }
    }
    
    open func fileIsExit(_ fileName:String) -> Bool {
        let xibFile = Bundle.main.path(forResource: fileName, ofType: "nib")
        return xibFile != nil
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath,tableView: tableView)
        let identifier = self.obtainCellNameWithCell(cellData!, tableView: tableView, cellForRowAtIndexPath: indexPath)
        
        if identifier.count == 0 {
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
    
    open func headerFooterDataWithType(type:CHGTableViewHeaderFooterViewType,section:NSInteger) -> Any? {
        let headerFooterDatas:[Any]? =
            type == CHGTableViewHeaderFooterViewType.HeaderType
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas
        if headerFooterDatas != nil && headerFooterDatas?.count != 0 {
            if section >= (headerFooterDatas?.count)! {
                return nil
            }
            return headerFooterDatas?[section]
        }
        return nil
    }
    
    open func tableview(_ tableView:UITableView,tableViewHeaderFooterViewType type:CHGTableViewHeaderFooterViewType,viewForHeaderInSection section:NSInteger) -> UIView? {
        //获取headerFooter的Item 数据
        let headerFooterData:Any? = self.headerFooterDataWithType(type: type, section: section)
        if headerFooterData == nil {
            return nil
        }
        let identifier:String =
            type == CHGTableViewHeaderFooterViewType.HeaderType ? self.obtainHeaderNameWithHeader(headerFooterData!, tableView: tableView, viewForHeaderInSection: section)
                :
                self.obtainFooterNameWithFooter(headerFooterData!, tableView: tableView, viewForFooterInSection: section)
        
        if identifier.count == 0 {
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
        view_.headerFooter(section: section, tableView: tableView, data: headerFooterData!, type: type)
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
            tableView.tableViewDidSelectRowBlock!(tableView,indexPath,self.cellDataWithIndexPath(indexPath,tableView: tableView)!)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidScrollBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidScrollBlock!(scrollView)
    }
    
    @available(iOS 3.2, *)
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidZoomBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidZoomBlock!(scrollView)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillBeginDraggingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillBeginDraggingBlock!(scrollView)
    }
    
    @available(iOS 5.0, *)
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillEndDraggingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillEndDraggingBlock!(scrollView,velocity,targetContentOffset)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndDraggingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndDraggingBlock!(scrollView,decelerate)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillBeginDeceleratingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillBeginDeceleratingBlock!(scrollView)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndDeceleratingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndDeceleratingBlock!(scrollView)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndScrollingAnimationBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndScrollingAnimationBlock!(scrollView)
    }
    
    
    @available(iOS 2.0, *)
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.viewForZoomingBlock != nil else {
            return nil
        }
        return tableView.scrollListener?.viewForZoomingBlock!(scrollView)
    }
    
    @available(iOS 3.2, *)
    open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillBeginZoomingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillBeginZoomingBlock!(scrollView,view)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndZoomingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndZoomingBlock!(scrollView,view,scale)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewShouldScrollToTopBlock != nil else {
            return scrollView.scrollsToTop
        }
        return (tableView.scrollListener?.scrollViewShouldScrollToTopBlock!(scrollView))!
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidScrollToTopBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidScrollToTopBlock!(scrollView)
    }
    
    @available(iOS 11.0, *)
    open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidChangeAdjustedContentInsetBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidChangeAdjustedContentInsetBlock!(scrollView)
    }
}

