//
//  CHGCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// collectionViewDidSelectRow 回调
public typealias CHGCollectionViewDidSelectItemAtIndexPathBlock = (_ collectionView:UICollectionView,_ indexPath:IndexPath,_ itemData:AnyObject)->Void

public protocol CHGCollectionViewAdapterProtocol :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func obtainCellNameWithCell(_ data:AnyObject,collectionView:UICollectionView,cellForItemAtIndexPath indexPath:IndexPath) -> NSString
    
    func obtainSupplementaryElementNameWithCell(_ data:AnyObject,collectionView:UICollectionView,viewForSupplementaryElementOfKind kind:NSString,indexPath:IndexPath) -> NSString
}

open class CHGCollectionViewAdapter: NSObject,CHGCollectionViewAdapterProtocol {
    
    public var cellName:NSString? = ""
    public var headerName:NSString? = ""
    public var footerName:NSString? = ""
    public var adapterData:CHGCollectionViewAdapterData = CHGCollectionViewAdapterData.init()
    public var rowsOfSectionKeyName:Any?
    //    public var collectionViewDeselectRowAtIndexPathAnimation:Bool = true
    public var controller:UIViewController?
    public var tag:NSInteger?
    
    open func obtainCellNameWithCell(_ data: AnyObject, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> NSString {
        return self.cellName!
    }
    
    open func obtainSupplementaryElementNameWithCell(_ data: AnyObject, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: NSString, indexPath: IndexPath) -> NSString {
        return (kind.isEqual(to: UICollectionElementKindSectionHeader) ? self.headerName : self.footerName)!
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        let cellDatas = self.adapterData.cellDatas;
        if cellDatas == nil || cellDatas?.count == 0 {
            return 0;
        }
        return cellDatas!.count;
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellDatas = self.adapterData.cellDatas;
        if cellDatas?.count == 0 {
            return 0
        }
        
        if self.rowsOfSectionKeyName != nil &&  !(cellDatas![section] is NSArray){
            if rowsOfSectionKeyName is String || rowsOfSectionKeyName is NSString {
                return ((cellDatas![section] as AnyObject).value(forKey: self.rowsOfSectionKeyName! as! String) as! NSArray).count
            } else {
                return (cellDatas![section][keyPath:rowsOfSectionKeyName as! AnyKeyPath] as! NSArray).count
            }
        }
        let cellData = cellDatas![section]
        if cellData is NSArray {
            return (cellData as! NSArray).count
        } else {
            return 1
        }
    }
    
    open func cellDataWithIndexPath(_ indexPath:IndexPath) -> AnyObject? {
        if self.adapterData.cellDatas?.count == 0 {
            return nil
        }
        let sectionData = self.adapterData.cellDatas![indexPath.section]
        if self.rowsOfSectionKeyName != nil && !(sectionData is NSArray) {
            var tempArray:NSArray = []
            if rowsOfSectionKeyName is String || rowsOfSectionKeyName is NSString {
                tempArray = (sectionData as AnyObject).value(forKey: rowsOfSectionKeyName as! String) as! NSArray
            } else {
                tempArray = sectionData[keyPath:rowsOfSectionKeyName as! AnyKeyPath] as! NSArray
            }
            return tempArray[indexPath.row] as AnyObject
        } else {
            return sectionData is NSArray ? (sectionData as! NSArray)[indexPath.row] as AnyObject : sectionData as AnyObject
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath)
        let identifier:NSString = self.obtainCellNameWithCell(cellData!, collectionView: collectionView, cellForItemAtIndexPath: indexPath)
        if identifier.length == 0 {
            print("cellName不能为空")
            return UICollectionViewCell()
        }
        if self.fileIsExit(identifier as String) {
            collectionView.register(UINib.init(nibName: identifier as String as String, bundle: nil), forCellWithReuseIdentifier: identifier as String)
        } else {
            let NameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let classAllNameClass:AnyClass = NSClassFromString("\(NameSpace).\(identifier)")!
            collectionView.register(classAllNameClass, forCellWithReuseIdentifier: identifier as String)
        }
        let cell:CHGCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier as String, for: indexPath) as! CHGCollectionViewCell
        cell.eventTransmissionBlock = collectionView.eventTransmissionBlock
        cell.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: cellData)
        return cell
    }
    
    open func fileIsExit(_ fileName:String) -> Bool {
        let xibFile = Bundle.main.path(forResource: fileName, ofType: "nib")
        return xibFile != nil
    }
    
    open func defaultReusableView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath, headerFooterData:AnyObject?)->CHGCollectionReusableView {
        collectionView.register(CHGCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier:"CHGCollectionReusableView" )
        let reusableView:CHGCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:"CHGCollectionReusableView" , for: indexPath) as! CHGCollectionReusableView
        reusableView.eventTransmissionBlock = collectionView.eventTransmissionBlock
        reusableView.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind as NSString, reusableViewData: headerFooterData)
        return reusableView
    }
    
    open func headerFooterDataWithrSupplementaryElementOfKind(kind:NSString,indexPath:IndexPath) -> AnyObject? {
        let reusableViewData:NSArray? =
            ((kind as NSString).isEqual(to: UICollectionElementKindSectionHeader)
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas)
        if reusableViewData == nil || (reusableViewData?.count)! == 0 || indexPath.section >= (reusableViewData?.count)! {
            return nil
        }
        return reusableViewData?[indexPath.section] as AnyObject
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableViewData:NSArray? =
            ((kind as NSString).isEqual(to: UICollectionElementKindSectionHeader)
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas)
        let headerFooterData:AnyObject? = self.headerFooterDataWithrSupplementaryElementOfKind(kind: kind as NSString, indexPath: indexPath)
        if reusableViewData == nil || reusableViewData?.count == 0 || indexPath.section >= reusableViewData?.count ?? 0 {
            return self.defaultReusableView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath, headerFooterData: headerFooterData)
        }
        let identifier:NSString = self.obtainSupplementaryElementNameWithCell(headerFooterData!, collectionView: collectionView, viewForSupplementaryElementOfKind: kind as NSString, indexPath: indexPath)
        if identifier.length == 0 {
            return self.defaultReusableView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath, headerFooterData: headerFooterData)
        }
        if self.fileIsExit(identifier as String) {
            collectionView.register(UINib(nibName: identifier as String, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier as String)
        } else {
            let NameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let classAllNameClass:AnyClass? = NSClassFromString("\(NameSpace).\(identifier)")
            collectionView.register(classAllNameClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier as String)
        }
        
        let reusableView:CHGCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier as String, for: indexPath) as! CHGCollectionReusableView
        reusableView.eventTransmissionBlock = collectionView.eventTransmissionBlock
        reusableView.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind as NSString, reusableViewData: headerFooterData)
        return reusableView
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.collectionViewDidSelectItemAtIndexPathBlock != nil) {
            collectionView.collectionViewDidSelectItemAtIndexPathBlock!(collectionView,indexPath,self.cellDataWithIndexPath(indexPath)!)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is CHGCollectionViewCell {
            (cell as! CHGCollectionViewCell).cellWillAppear()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if view is CHGCollectionReusableView {
            (view as! CHGCollectionReusableView).reusableViewWillAppear()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is CHGCollectionViewCell {
            (cell as! CHGCollectionViewCell).cellDidDisappear()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if view is CHGCollectionReusableView {
            (view as! CHGCollectionReusableView).reusableViewDidDisappear()
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidScrollBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidScrollBlock!(scrollView)
    }
    
    @available(iOS 3.2, *)
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidZoomBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidZoomBlock!(scrollView)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewWillBeginDraggingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewWillBeginDraggingBlock!(scrollView)
    }
    
    @available(iOS 5.0, *)
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewWillEndDraggingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewWillEndDraggingBlock!(scrollView,velocity,targetContentOffset)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidEndDraggingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidEndDraggingBlock!(scrollView,decelerate)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewWillBeginDeceleratingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewWillBeginDeceleratingBlock!(scrollView)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidEndDeceleratingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidEndDeceleratingBlock!(scrollView)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidEndScrollingAnimationBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidEndScrollingAnimationBlock!(scrollView)
    }
    
    
    @available(iOS 2.0, *)
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.viewForZoomingBlock != nil else {
            return nil
        }
        return collectionView.scrollListener?.viewForZoomingBlock!(scrollView)
    }
    
    @available(iOS 3.2, *)
    open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewWillBeginZoomingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewWillBeginZoomingBlock!(scrollView,view)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidEndZoomingBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidEndZoomingBlock!(scrollView,view,scale)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewShouldScrollToTopBlock != nil else {
            return scrollView.scrollsToTop
        }
        return (collectionView.scrollListener?.scrollViewShouldScrollToTopBlock!(scrollView))!
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidScrollToTopBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidScrollToTopBlock!(scrollView)
    }
    
    @available(iOS 11.0, *)
    open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        let collectionView:UICollectionView = scrollView as! UICollectionView
        guard collectionView.scrollListener?.scrollViewDidChangeAdjustedContentInsetBlock != nil else {
            return
        }
        collectionView.scrollListener?.scrollViewDidChangeAdjustedContentInsetBlock!(scrollView)
    }
    
}
