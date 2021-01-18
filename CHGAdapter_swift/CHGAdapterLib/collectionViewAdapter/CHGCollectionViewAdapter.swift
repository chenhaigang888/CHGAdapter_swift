//
//  CHGCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// collectionViewDidSelectRow 回调
public typealias CHGCollectionViewDidSelectItemAtIndexPathBlock = (_ collectionView:UICollectionView,_ indexPath:IndexPath,_ itemData:Any)->Void

public protocol CHGCollectionViewAdapterProtocol :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CHGSubDataOfKeyPathDelegate {
    
    func obtainCellClassWithCell(_ data:Any,collectionView:UICollectionView,cellForItemAtIndexPath indexPath:IndexPath) -> AnyClass?
    
    func obtainSupplementaryElementClassWithCell(_ data:Any,collectionView:UICollectionView,viewForSupplementaryElementOfKind kind:NSString,indexPath:IndexPath) -> AnyClass?
}

open class CHGCollectionViewAdapter: NSObject,CHGCollectionViewAdapterProtocol {
    
    open var cellName:AnyClass?
    open var headerName:AnyClass?
    open var footerName:AnyClass?
    open var adapterData:CHGCollectionViewAdapterData = CHGCollectionViewAdapterData.init()
    open var keyPathOfSubData:Any?
    weak open var controller:UIViewController?
    open var tag:NSInteger?
    
    open func obtainCellClassWithCell(_ data: Any, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> AnyClass? {
        return self.cellName
    }
    
    open func obtainSupplementaryElementClassWithCell(_ data: Any, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: NSString, indexPath: IndexPath) -> AnyClass? {
        return (kind.isEqual(to: UICollectionView.elementKindSectionHeader) ? self.headerName : self.footerName)!
    }
    
    open func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        return self.keyPathOfSubData
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.adapterData.cellDatas?.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellDatas:[Any] = self.adapterData.cellDatas else { return 0 }
        if let subDataKeyPathTemp = self.subDataKeyPath(IndexPath.init(row: 0, section: section), targetView: collectionView) ,
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
    
    open func cellDataWithIndexPath(_ indexPath:IndexPath,collectionView:UICollectionView) -> Any? {
        if self.adapterData.cellDatas?.count == 0 {
            return nil
        }
        
        let sectionData = self.adapterData.cellDatas![indexPath.section]
        let subDataKeyPathTemp = self.subDataKeyPath(indexPath, targetView: collectionView)
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
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath,collectionView: collectionView)
        guard let cellClass:AnyClass = self.obtainCellClassWithCell(cellData!, collectionView: collectionView, cellForItemAtIndexPath: indexPath) else { return UICollectionViewCell() }
        let classAllName = NSStringFromClass(cellClass)
        
        
        if Utils.fileIsExit(moduleName: Utils.getModuleName(anyClass: cellClass), fileName: Utils.getShortClassName(anyClass: cellClass)) {
            collectionView.register(UINib.init(nibName: Utils.getShortClassName(anyClass: cellClass),
                                               bundle: Utils.getBundle(anyClass: cellClass)),
                                    forCellWithReuseIdentifier: classAllName)
        } else {
            collectionView.register(cellClass, forCellWithReuseIdentifier: classAllName)
        }
        let cell:CHGCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: classAllName, for: indexPath) as! CHGCollectionViewCell
        cell.cellForRowAt(indexPath: indexPath, targetView: collectionView, model: cellData!, eventTransmissionBlock: collectionView.eventTransmissionBlock)
        return cell
    }
    
    open func defaultReusableView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath, headerFooterData:Any?)->CHGCollectionReusableView {
        collectionView.register(CHGCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier:"CHGCollectionReusableView" )
        let reusableView:CHGCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:"CHGCollectionReusableView" , for: indexPath) as! CHGCollectionReusableView
        if headerFooterData != nil {
            reusableView.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: headerFooterData!, eventTransmissionBlock: collectionView.eventTransmissionBlock)
        }
        return reusableView
    }
    
    open func headerFooterDataWithrSupplementaryElementOfKind(kind:NSString,indexPath:IndexPath) -> Any? {
        let reusableViewData:[Any]? =
            ((kind as NSString).isEqual(to: UICollectionView.elementKindSectionHeader)
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas)
        if reusableViewData == nil || (reusableViewData?.count)! == 0 || indexPath.section >= (reusableViewData?.count)! {
            return nil
        }
        return reusableViewData?[indexPath.section]
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableViewData:[Any]? =
            ((kind as NSString).isEqual(to: UICollectionView.elementKindSectionHeader)
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas)
        let headerFooterData:Any? = self.headerFooterDataWithrSupplementaryElementOfKind(kind: kind as NSString, indexPath: indexPath)
        if reusableViewData == nil || reusableViewData?.count == 0 || indexPath.section >= reusableViewData?.count ?? 0 {
            return self.defaultReusableView(collectionView, viewForSupplementaryElementOfKind: kind as String, at: indexPath, headerFooterData: headerFooterData)
        }
        
        guard let headerFooterClass:AnyClass = self.obtainSupplementaryElementClassWithCell(headerFooterData!, collectionView: collectionView, viewForSupplementaryElementOfKind: kind as NSString, indexPath: indexPath) else { return self.defaultReusableView(collectionView, viewForSupplementaryElementOfKind: kind as String, at: indexPath, headerFooterData: headerFooterData) }
        let classAllName = NSStringFromClass(headerFooterClass)
        
        if Utils.fileIsExit(moduleName: Utils.getModuleName(anyClass: headerFooterClass), fileName: Utils.getShortClassName(anyClass: headerFooterClass)) {
            collectionView.register(UINib(nibName: Utils.getShortClassName(anyClass: headerFooterClass),
                                          bundle: Utils.getBundle(anyClass: headerFooterClass)),
                                    forSupplementaryViewOfKind: kind as String,
                                    withReuseIdentifier: classAllName)
        } else {
            collectionView.register(headerFooterClass, forSupplementaryViewOfKind: kind as String, withReuseIdentifier: classAllName)
        }
        let reusableView:CHGCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind as String, withReuseIdentifier: classAllName, for: indexPath) as! CHGCollectionReusableView
        reusableView.reusableView(for: collectionView, indexPath: indexPath, kind: kind, model: headerFooterData!, eventTransmissionBlock: collectionView.eventTransmissionBlock)
        return reusableView
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let collectionViewDidSelectItemAtIndexPathBlock = collectionView.collectionViewDidSelectItemAtIndexPathBlock {
            collectionViewDidSelectItemAtIndexPathBlock(collectionView,indexPath,cellDataWithIndexPath(indexPath,collectionView: collectionView)!)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell:CHGCollectionViewCell = cell as? CHGCollectionViewCell {
            cell.cellWillAppear()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if let view:CHGCollectionReusableView = view as? CHGCollectionReusableView {
            view.reusableViewWillAppear()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell:CHGCollectionViewCell = cell as? CHGCollectionViewCell {
            cell.cellDidDisappear();
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if let view:CHGCollectionReusableView = view as? CHGCollectionReusableView {
            view.reusableViewDidDisappear()
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidScroll(scrollView: scrollView)
        }
    }
    
    @available(iOS 3.2, *)
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidZoom(scrollView: scrollView)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillBeginDragging(scrollView: scrollView)
        }
    }
    
    @available(iOS 5.0, *)
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillEndDragging(scrollView: scrollView, with: velocity, targetContentOffset: targetContentOffset)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndDragging(scrollView: scrollView, will: decelerate)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillBeginDecelerating(scrollView: scrollView)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndDecelerating(scrollView: scrollView)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndScrollingAnimation(scrollView: scrollView)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return nil}
        for scrollViewDelegate in scrollViewDelegates {
            return scrollViewDelegate.chg_viewForZoomingInScrollView(scrollView: scrollView)
        }
        
        return nil
    }
    
    @available(iOS 3.2, *)
    open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewWillBeginZooming(scrollView: scrollView, with: view)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidEndZooming(scrollView: scrollView, with: view, at: scale)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return true}
        for scrollViewDelegate in scrollViewDelegates {
            return scrollViewDelegate.chg_scrollViewShouldScrollToTop(scrollView: scrollView)
        }
        
        return true
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidScrollToTop(scrollView: scrollView)
        }
    }
    
    @available(iOS 11.0, *)
    open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        guard let tableView:UICollectionView = scrollView as? UICollectionView , let scrollViewDelegates = tableView.scrollViewDelegates else { return }
        for scrollViewDelegate in scrollViewDelegates {
            scrollViewDelegate.chg_scrollViewDidChangeAdjustedContentInset(scrollView: scrollView)
        }
    }
    
}
