//
//  CHGCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// tableViewDidSelectRow 回调
typealias CHGCollectionDidSelectRowBlock = (_ collectionView:UICollectionView,_ indexPath:IndexPath,_ itemData:AnyObject)->Void

protocol CHGCollectionViewAdapterProtocol :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func obtainCellNameWithCell(_ data:AnyObject,collectionView:UICollectionView,cellForItemAtIndexPath indexPath:IndexPath) -> NSString
    
    func obtainSupplementaryElementNameWithCell(_ data:AnyObject,collectionView:UICollectionView,viewForSupplementaryElementOfKind kind:NSString,indexPath:IndexPath) -> NSString
}

class CHGCollectionViewAdapter: NSObject,CHGCollectionViewAdapterProtocol {
    
    var cellName:NSString? = ""
    var headerName:NSString? = ""
    var footerName:NSString? = ""
    var adapterData:CHGCollectionViewAdapterData?
    var rowsOfSectionKeyName:NSString?
    var tableViewDeselectRowAtIndexPathAnimation:Bool = true
    
    func obtainCellNameWithCell(_ data: AnyObject, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> NSString {
        return self.cellName!
    }
    
    func obtainSupplementaryElementNameWithCell(_ data: AnyObject, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: NSString, indexPath: IndexPath) -> NSString {
        return (kind.isEqual(to: UICollectionElementKindSectionHeader) ? self.headerName : self.footerName)!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let cellDatas = self.adapterData?.cellDatas;
        if self.rowsOfSectionKeyName != nil {
            if cellDatas![0] is NSArray {
                return (cellDatas?.count)!
            } else {
                return (cellDatas?.count)!
            }
        } else {
            if cellDatas![0] is NSArray {
                return (cellDatas?.count)!
            } else {
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            return (cellDatas?.count)!
        }
    }
    
    func cellDataWithIndexPath(_ indexPath:IndexPath) -> AnyObject? {
        if self.adapterData?.cellDatas?.count == 0 {
            return nil
        }
        let sectionData:AnyObject = self.adapterData?.cellDatas![indexPath.section] as AnyObject
        let cellData:AnyObject?
        
        if self.rowsOfSectionKeyName != nil && !(sectionData is NSArray) {
            let tempArray:NSArray = sectionData.value(forKey: self.rowsOfSectionKeyName! as String) as! NSArray
            cellData = tempArray[indexPath.row] as AnyObject
        } else {
            if sectionData is NSArray {
                cellData = sectionData[indexPath.row]
            } else {
                cellData = sectionData;
            }
        }
        return cellData
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath)
        let identifier:NSString = self.obtainCellNameWithCell(cellData!, collectionView: collectionView, cellForItemAtIndexPath: indexPath)
        if identifier.length == 0 {
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
    
    func fileIsExit(_ fileName:String) -> Bool {
        let xibFile = Bundle.main.path(forResource: fileName, ofType: "nib")
        return xibFile != nil
    }
    
}
