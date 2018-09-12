//
//  CHGSimpleCollectionViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

/// 所有UICollectionView使用CHGSimpleCollectionViewAdapter类中的Model类都应该实现此协议,此协议主要描述model在collectionView中的布局信息及对应的CHGCollectionViewCell,model用在CHGCollectionViewCell中
public protocol CHGCollectionViewCellModelProtocol {
    
    /// 如果collectionView registered class 这里的返回结果作为获取CHGCollectionViewCell identifier。如果没有注册过class 这里的结果将作为CHGCollectionViewCell的class进行注册并且以此类的名称作为identifier
    ///
    /// - Parameters:
    ///   - collectionView: model所在的collectionView的cell中（model可能会存在很多collectionView、collectionViewCell）
    ///   - atIndexPath: model在collectionView中所处的indexPath
    func cellClassNameInCollectionView(collectionView:UICollectionView, atIndexPath:IndexPath)->String
    
    ///返回item的大小
    func cellItemSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

public extension CHGCollectionViewCellModelProtocol {
    func cellItemSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.itemSize
        }
        return CGSize.init(width: 50, height: 50)
    }
}

/// 所有UICollectionView使用CHGSimpleCollectionViewAdapter类中的Model类都应该实现此协议,此协议主要描述model在collectionView中的布局信息及对应的CHGCollectionReusableView，model用在CHGCollectionReusableView
public protocol CHGCollectionViewSupplementaryElementModelProtocol {
    
    /// 如果collectionView registerd class ，这里的返回结果作为获取CHGCollectionReusableView的identifier。如果没有注册过class，这里的结果将作为CHGCollectionReusableView的class进行注册并且以此类的名称作为identifier。
    ///
    /// - Parameters:
    ///   - collectionView: model所在的collectionView的reusableView中（model可能会存在很多collectionView、reusableView）
    ///   - kind: 表示model在collectionView的headerView或者footerView中
    /// - Returns: model在collectionView中所处的indexPath
    func reusableViewInCollectionView(collectionView:UICollectionView, supplementaryElementOfKind kind:String, atIndexPath indexPath:IndexPath) -> String
    ///动态设置每个分区的EdgeInsets 不包括header和footer
    func sectionInsetInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    ///动态设置每行的间距大小
    func minimumLineSpacingInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat
    ///动态设置每列的间距大小
    func minimumInteritemSpacingCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat
    ///动态设置某个分区头视图大小
    func referenceHeaderSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize
    ///动态设置某个分区尾视图大小
    func referenceFooterSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize
    
    func subDataKeyPath(_ indexPath:IndexPath,inCollectionView collectionView: UICollectionView) -> Any
}

public extension CHGCollectionViewSupplementaryElementModelProtocol {
    ///动态设置每个分区的EdgeInsets 不包括header和footer
    func sectionInsetInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.sectionInset
        }
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    ///动态设置每行的间距大小
    func minimumLineSpacingInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.minimumLineSpacing
        }
        return 0
    }
    
    ///动态设置每列的间距大小
    func minimumInteritemSpacingCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.minimumInteritemSpacing
        }
        return 0
    }
    
    ///动态设置某个分区头视图大小
    func referenceHeaderSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.headerReferenceSize
        }
        return CGSize.init(width: collectionView.frame.width, height: 30)
    }
    
    ///动态设置某个分区尾视图大小
    func referenceFooterSizeInCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.footerReferenceSize
        }
        return CGSize.init(width: collectionView.frame.width, height: 30)
    }
    
    func subDataKeyPath(_ indexPath:IndexPath,inCollectionView collectionView: UICollectionView) -> Any {
        return ""
    }
}

open class CHGSimpleCollectionViewAdapter: CHGCollectionViewAdapter {
    
    open override func obtainCellNameWithCell(_ data: AnyObject, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> NSString {
        guard let cellModelProtocol:CHGCollectionViewCellModelProtocol = data as? CHGCollectionViewCellModelProtocol else {
            return super.obtainCellNameWithCell(data, collectionView: collectionView, cellForItemAtIndexPath: indexPath)
        }
        return cellModelProtocol.cellClassNameInCollectionView(collectionView: collectionView, atIndexPath: indexPath) as NSString
    }
    
    open override func obtainSupplementaryElementNameWithCell(_ data: AnyObject, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: NSString, indexPath: IndexPath) -> NSString {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol else {
            return super.obtainSupplementaryElementNameWithCell(data, collectionView: collectionView, viewForSupplementaryElementOfKind: kind, indexPath: indexPath)
        }
        return supplementaryElementModelProtocol.reusableViewInCollectionView(collectionView: collectionView, supplementaryElementOfKind: kind as String, atIndexPath: indexPath) as NSString
    }
    
    ///动态设置每个分区的EdgeInsets 不包括header和footer
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionElementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section)) as? CHGCollectionViewSupplementaryElementModelProtocol else {
            if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
                let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                return layout.sectionInset
            }
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        return supplementaryElementModelProtocol.sectionInsetInCollectionView(collectionView: collectionView, layout: collectionViewLayout, insetForSectionAt: section)
    }
    
    ///动态设置每行的间距大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionElementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section)) as? CHGCollectionViewSupplementaryElementModelProtocol else {
            if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
                let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                return layout.minimumLineSpacing
            }
            return 0
        }
        return supplementaryElementModelProtocol.minimumLineSpacingInCollectionView(collectionView:collectionView, layout: collectionViewLayout, atSection: section)
    }
    
    ///动态设置每列的间距大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionElementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section)) as? CHGCollectionViewSupplementaryElementModelProtocol else {
            if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
                let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                return layout.minimumInteritemSpacing
            }
            return 0
        }
        return supplementaryElementModelProtocol.minimumInteritemSpacingCollectionView(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
    }
    
    
    //动态设置某个分区头视图大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionElementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section)) as? CHGCollectionViewSupplementaryElementModelProtocol else {
            if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
                let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                return layout.headerReferenceSize
            }
            return CGSize.init(width: collectionView.frame.width, height: 0)
        }
        return supplementaryElementModelProtocol.referenceHeaderSizeInCollectionView(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        
    }
    
    ///动态设置每个Item的尺寸大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellModelProtocol:CHGCollectionViewCellModelProtocol = cellDataWithIndexPath(indexPath,collectionView: collectionView) as? CHGCollectionViewCellModelProtocol else {
            if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
                let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                return layout.itemSize
            }
            return CGSize.init(width: 50, height: 50)
        }
        return cellModelProtocol.cellItemSizeInCollectionView(collectionView: collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
    
    //动态设置某个分区尾视图大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionElementKindSectionFooter as NSString, indexPath: IndexPath.init(row: 0, section: section)) as? CHGCollectionViewSupplementaryElementModelProtocol else {
            if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
                let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                return layout.footerReferenceSize
            }
            return CGSize.init(width: collectionView.frame.width, height: 0)
        }
        return supplementaryElementModelProtocol.referenceFooterSizeInCollectionView(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
    }
    
    open override func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        guard let supplementaryElementModelProtocol:CHGCollectionViewSupplementaryElementModelProtocol = self.adapterData.cellDatas![indexPath.section] as? CHGCollectionViewSupplementaryElementModelProtocol else {
            return super.subDataKeyPath(indexPath, targetView: targetView)
        }
        let keyPath = supplementaryElementModelProtocol.subDataKeyPath(indexPath, inCollectionView: targetView as! UICollectionView)
        if keyPath is NSString || keyPath is String {
            let keyPathStr:NSString = keyPath as! NSString
            if keyPathStr.length == 0 {
                return super.subDataKeyPath(indexPath, targetView: targetView)
            } else {
                return keyPathStr
            }
        }
        return keyPath
    }
    
}

