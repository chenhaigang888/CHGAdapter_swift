//
//  CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 回调
public typealias CHGCallBack = (_ data:Any?) -> Any?

/// 事件传输block target.
/// - Parameters:
///   - target: 当前事件发生的场所（一般是cell、header、footer、adapter中）
///   - params: 事件发生的场所传递出来的参数
///   - tag: 区分事件发生的场所中的多个事件
///   - callBack: 当当前类中处理完事件后异步通知事件所发生的场所
/// - Returns: 当当前类中处理完事件后同步步通知事件所发生的场所
public typealias CHGEventTransmissionBlock = (_ target:Any?,_ params:Any?,_ tag:NSInteger,_ callBack:CHGCallBack?) -> Any?

/// tableViewDidSelectRow 回调
public typealias CHGTableViewDidSelectRowBlock = (_ tableView:UITableView,_ indexPath:IndexPath, _ itemData:Any) -> Void

public typealias CHGTableViewCommitEditForRowBlock = (_ tableView:UITableView,_ editingStyle: UITableViewCell.EditingStyle, _ indexPath:IndexPath, _ itemData:Any) -> Void

public typealias CHGTableViewDidEndEditingBlock = (_ tableView: UITableView, _ indexPath: IndexPath?, _ itemData:Any) -> Void

public typealias CHGTableViewWillBeginEditingBlock = (_ tableView: UITableView, _ indexPath: IndexPath?, _ itemData:Any) -> Void


public protocol CHGTableViewAdapterProtocol:UITableViewDelegate,UITableViewDataSource, CHGSubDataOfKeyPathDelegate{
    
    func obtainCellClassWithCell(_ data:Any ,tableView:UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> AnyClass?
    
    func obtainHeaderClassWithHeader(_ data:Any,tableView:UITableView, viewForHeaderInSection section:NSInteger) -> AnyClass?
    
    func obtainFooterClassWithFooter(_ data:Any,tableView:UITableView, viewForFooterInSection section:NSInteger) -> AnyClass?
}

open class CHGTableViewAdapter: NSObject,CHGTableViewAdapterProtocol {
    
    open var cellName:AnyClass?
    open var headerName:AnyClass?
    open var footerName:AnyClass?
    
    /// 如果cell、headerView、footerView的高度都统一可以通过直接设置以下参数进行设置
    open var cellHeight:CGFloat = 44
    open var headerHeight:CGFloat = 0.01
    open var footerHeight:CGFloat = 0.01
    
    open var adapterData:CHGTableViewAdapterData = CHGTableViewAdapterData.init()
    open var keyPathOfSubData:Any?
    open var tableViewDeselectRowAtIndexPathAnimation:Bool = true
    open var tag:NSInteger = 0
    weak open var controller:UIViewController?
    
    open var canEditEnable:Bool? = false
    open var editingStyle: UITableViewCell.EditingStyle = .none
    open var titleForDeleteConfirmationButton:String?
    open var rowActions:[UITableViewRowAction]?
    open var shouldIndentWhileEditingRow: Bool = false
    
    
    open func obtainCellClassWithCell(_ data: Any, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> AnyClass? {
        return self.cellName!;
    }
    
    open func obtainHeaderClassWithHeader(_ data: Any, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> AnyClass? {
        return self.headerName!;
    }
    
    open func obtainFooterClassWithFooter(_ data: Any, tableView: UITableView, viewForFooterInSection section: NSInteger) -> AnyClass? {
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
        return self.adapterData.cellDatas?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellDatas:[Any] = self.adapterData.cellDatas else { return 0 }
        if let subDataKeyPathTemp = self.subDataKeyPath(IndexPath.init(row: 0, section: section), targetView: tableView) ,
           !(cellDatas[section] is Array<Any>) {
            guard let subDataKeyPathTempStr:String = subDataKeyPathTemp as? String,
                  subDataKeyPathTempStr.count > 0,
                  let cellDataItem:AnyObject = cellDatas[section] as? AnyObject,
                  let items:[Any] = cellDataItem.value(forKey: subDataKeyPathTempStr) as? [Any] else {
                return (cellDatas[section][keyPath:subDataKeyPathTemp as! AnyKeyPath] as! [Any]).count
            }
            return items.count
        }

        if let cellData:[Any] = cellDatas[section] as? [Any] {
            return cellData.count
        }
        return 1
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
        if subDataKeyPathTemp != nil && !(sectionData is Array<Any>) {
            var tempArray:Array<Any> = []
            if subDataKeyPathTemp is String || subDataKeyPathTemp is NSString {
                if (subDataKeyPathTemp as? NSString)?.length != 0 {
                    tempArray = (sectionData as AnyObject).value(forKey: subDataKeyPathTemp as! String) as! Array<Any>
                }
            } else {
                tempArray = sectionData[keyPath:subDataKeyPathTemp as! AnyKeyPath] as! Array<Any>
            }
            return tempArray.count == 0 ? sectionData : tempArray[indexPath.row]
        } else {
            if let array:Array = sectionData as? Array<Any> {
                return array[indexPath.row]
            }
            return sectionData
        }
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath,tableView: tableView)
        guard let cellClass = self.obtainCellClassWithCell(cellData!, tableView: tableView, cellForRowAtIndexPath: indexPath) else { return UITableViewCell() }
        let classAllName = NSStringFromClass(cellClass)
        var cell = tableView.dequeueReusableCell(withIdentifier: classAllName)
        if cell == nil {
            if Utils.fileIsExit(moduleName: Utils.getModuleName(anyClass: cellClass), fileName: Utils.getShortClassName(anyClass: cellClass)) {
                tableView.register(UINib (nibName:Utils.getShortClassName(anyClass: cellClass),
                                          bundle: Utils.getBundle(anyClass: cellClass)),
                                   forCellReuseIdentifier: classAllName)
            } else {
                tableView.register(cellClass, forCellReuseIdentifier: classAllName)
            }
            cell = tableView.dequeueReusableCell(withIdentifier: classAllName, for: indexPath)
        }
        let cell_:CHGTableViewCell = cell as! CHGTableViewCell
        cell_.cellForRowAt(indexPath: indexPath, targetView: tableView, model: cellData!, eventTransmissionBlock: tableView.eventTransmissionBlock)
        return cell_
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGAdapterViewType.HeaderType, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGAdapterViewType.FooterType, viewForHeaderInSection: section)
    }
    
    open func headerFooterDataWithType(type:CHGAdapterViewType,section:NSInteger) -> Any? {
        let headerFooterDatas:[Any]? =
            type == CHGAdapterViewType.HeaderType
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
    
    open func tableview(_ tableView:UITableView,tableViewHeaderFooterViewType type:CHGAdapterViewType,viewForHeaderInSection section:NSInteger) -> UIView? {
        //获取headerFooter的Item 数据
        let headerFooterData:Any? = self.headerFooterDataWithType(type: type, section: section)
        if headerFooterData == nil {
            return nil
        }
        guard let headerFooterClass:AnyClass =
            type == CHGAdapterViewType.HeaderType ? self.obtainHeaderClassWithHeader(headerFooterData!, tableView: tableView, viewForHeaderInSection: section)
                :
                self.obtainFooterClassWithFooter(headerFooterData!, tableView: tableView, viewForFooterInSection: section) else { return nil }
        
        let classAllName = NSStringFromClass(headerFooterClass)
        
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: classAllName as String)
        if view == nil {
            if Utils.fileIsExit(moduleName: Utils.getModuleName(anyClass: headerFooterClass), fileName: Utils.getShortClassName(anyClass: headerFooterClass)) {
                tableView.register(UINib(nibName: Utils.getShortClassName(anyClass: headerFooterClass),
                                         bundle: Utils.getBundle(anyClass: headerFooterClass)),
                                   forHeaderFooterViewReuseIdentifier: classAllName)
            } else {
                tableView.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: classAllName)
            }
            view = tableView.dequeueReusableHeaderFooterView(withIdentifier: classAllName)
        }
        let view_:CHGTableViewHeaderFooterView = view as! CHGTableViewHeaderFooterView
        view_.headerFooter(for: section, in: tableView, model: headerFooterData!, type: type, eventTransmissionBlock: tableView.eventTransmissionBlock)
        return view_
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view:CHGTableViewHeaderFooterView = view as? CHGTableViewHeaderFooterView {
            view.headerFooterViewWillAppear(with: .HeaderType)
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell:CHGTableViewCell = cell as? CHGTableViewCell {
            cell.cellWillAppear()
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view:CHGTableViewHeaderFooterView = view as? CHGTableViewHeaderFooterView {
            view.headerFooterViewWillAppear(with: .FooterType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if let view:CHGTableViewHeaderFooterView = view as? CHGTableViewHeaderFooterView {
            view.headerFooterViewDidDisAppear(with: .HeaderType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell:CHGTableViewCell = cell as? CHGTableViewCell {
            cell.cellDidDisappear()
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if let view:CHGTableViewHeaderFooterView = view as? CHGTableViewHeaderFooterView {
            view.headerFooterViewDidDisAppear(with: .FooterType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: self.tableViewDeselectRowAtIndexPathAnimation)
        if let tableViewDidSelectRowBlock = tableView.tableViewDidSelectRowBlock {
            tableViewDidSelectRowBlock(tableView,indexPath,self.cellDataWithIndexPath(indexPath,tableView: tableView)!)
        }
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        canEditEnable ?? false
    }
    
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        editingStyle
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let tableViewCommitEditForRowBlock = tableView.tableViewCommitEditForRowBlock {
            tableViewCommitEditForRowBlock(tableView,editingStyle,indexPath,cellDataWithIndexPath(indexPath,tableView: tableView)!)
        }
    }
    
    open func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return titleForDeleteConfirmationButton
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        rowActions
    }
    
    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if let tableViewDidEndEditingBlock = tableView.tableViewDidEndEditingBlock, let indexPath = indexPath {
            tableViewDidEndEditingBlock(tableView,indexPath,cellDataWithIndexPath(indexPath, tableView: tableView)!)
        }
    }
    
    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if let tableViewWillBeginEditingBlock = tableView.tableViewWillBeginEditingBlock {
            tableViewWillBeginEditingBlock(tableView,indexPath,cellDataWithIndexPath(indexPath, tableView: tableView)!)
        }
    }
    
    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        shouldIndentWhileEditingRow
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidScroll(scrollView: scrollView)
        }
    }
    
    @available(iOS 3.2, *)
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidZoom(scrollView: scrollView)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillBeginDragging(scrollView: scrollView)
        }
    }
    
    @available(iOS 5.0, *)
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillEndDragging(scrollView: scrollView, with: velocity, targetContentOffset: targetContentOffset)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndDragging(scrollView: scrollView, will: decelerate)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillBeginDecelerating(scrollView: scrollView)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndDecelerating(scrollView: scrollView)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndScrollingAnimation(scrollView: scrollView)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return nil}
        for scrollViewDelegate in scrollViewDelegates {
            return scrollViewDelegate.chg_viewForZoomingInScrollView(scrollView: scrollView)
        }
        
        return nil
    }
    
    @available(iOS 3.2, *)
    open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillBeginZooming(scrollView: scrollView, with: view)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndZooming(scrollView: scrollView, with: view, at: scale)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return true}
        for scrollViewDelegate in scrollViewDelegates {
            return scrollViewDelegate.chg_scrollViewShouldScrollToTop(scrollView: scrollView)
        }
        
        return true
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidScrollToTop(scrollView: scrollView)
        }
    }
    
    @available(iOS 11.0, *)
    open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        guard let tableView:UITableView = scrollView as? UITableView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidChangeAdjustedContentInset(scrollView: scrollView)
        }
    }
}

