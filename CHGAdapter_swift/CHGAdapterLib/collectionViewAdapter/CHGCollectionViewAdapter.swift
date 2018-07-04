//
//  CHGCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// tableViewDidSelectRow 回调
public typealias CHGCollectionViewDidSelectItemAtIndexPathBlock = (_ collectionView:UICollectionView,_ indexPath:IndexPath,_ itemData:AnyObject)->Void

public protocol CHGCollectionViewAdapterProtocol :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func obtainCellNameWithCell(_ data:AnyObject,collectionView:UICollectionView,cellForItemAtIndexPath indexPath:IndexPath) -> NSString
    
    func obtainSupplementaryElementNameWithCell(_ data:AnyObject,collectionView:UICollectionView,viewForSupplementaryElementOfKind kind:NSString,indexPath:IndexPath) -> NSString
}

open class CHGCollectionViewAdapter: NSObject,CHGCollectionViewAdapterProtocol {
    
    public var cellName:NSString? = ""
    public var headerName:NSString? = ""
    public var footerName:NSString? = ""
    public var adapterData:CHGCollectionViewAdapterData?
    public var rowsOfSectionKeyName:NSString?
    //    public var tableViewDeselectRowAtIndexPathAnimation:Bool = true
    public var controller:UIViewController?
    public var tag:NSInteger?
    
    open func obtainCellNameWithCell(_ data: AnyObject, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> NSString {
        return self.cellName!
    }
    
    open func obtainSupplementaryElementNameWithCell(_ data: AnyObject, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: NSString, indexPath: IndexPath) -> NSString {
        return (kind.isEqual(to: UICollectionElementKindSectionHeader) ? self.headerName : self.footerName)!
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        let cellDatas = self.adapterData?.cellDatas;
        if cellDatas == nil || cellDatas?.count == 0 {
            return 0;
        }
        return cellDatas!.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellDatas = self.adapterData?.cellDatas;
        if cellDatas?.count == 0 {
            return 0
        }
        
        if self.rowsOfSectionKeyName != nil &&  !(cellDatas![section] is NSArray){
            return ((cellDatas![section] as AnyObject).value(forKey: self.rowsOfSectionKeyName! as String) as! NSArray).count
        }
        let cellData = cellDatas![section]
        if cellData is NSArray {
            return (cellData as! NSArray).count
        } else {
            return 1
        }
    }
    
    func cellDataWithIndexPath(_ indexPath:IndexPath) -> AnyObject? {
        if self.adapterData?.cellDatas?.count == 0 {
            return nil
        }
        let sectionData:AnyObject = self.adapterData?.cellDatas![indexPath.section] as AnyObject
        if self.rowsOfSectionKeyName != nil && !(sectionData is NSArray) {
            let tempArray:NSArray = sectionData.value(forKey: self.rowsOfSectionKeyName! as String) as! NSArray
            return tempArray[indexPath.row] as AnyObject
        } else {
            return sectionData is NSArray ? sectionData[indexPath.row] : sectionData
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    public func fileIsExit(_ fileName:String) -> Bool {
        let xibFile = Bundle.main.path(forResource: fileName, ofType: "nib")
        return xibFile != nil
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableViewData:NSArray? =
            ((kind as NSString).isEqual(to: UICollectionElementKindSectionHeader)
                ?
                    self.adapterData?.headerDatas
                :
                self.adapterData?.footerDatas)
        var headerFooterData:AnyObject? = nil
        
        if reusableViewData == nil || reusableViewData?.count == 0 || indexPath.section >= reusableViewData?.count ?? 0 {
            collectionView.register(CHGCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier:"CHGCollectionReusableView" )
            let reusableView:CHGCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:"CHGCollectionReusableView" , for: indexPath) as! CHGCollectionReusableView
            reusableView.eventTransmissionBlock = collectionView.eventTransmissionBlock
            reusableView.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind as NSString, reusableViewData: headerFooterData)
            return reusableView
        }
        
        headerFooterData = reusableViewData?[indexPath.section] as AnyObject
        let identifier:NSString = self.obtainSupplementaryElementNameWithCell(headerFooterData!, collectionView: collectionView, viewForSupplementaryElementOfKind: kind as NSString, indexPath: indexPath)
        
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.collectionViewDidSelectItemAtIndexPathBlock != nil) {
            collectionView.collectionViewDidSelectItemAtIndexPathBlock!(collectionView,indexPath,self.cellDataWithIndexPath(indexPath)!)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is CHGCollectionViewCell {
            (cell as! CHGCollectionViewCell).cellWillAppear()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if view is CHGCollectionReusableView {
            (view as! CHGCollectionReusableView).reusableViewWillAppear()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is CHGCollectionViewCell {
            (cell as! CHGCollectionViewCell).cellDidDisappear()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if view is CHGCollectionReusableView {
            (view as! CHGCollectionReusableView).reusableViewDidDisappear()
        }
    }
    
}
