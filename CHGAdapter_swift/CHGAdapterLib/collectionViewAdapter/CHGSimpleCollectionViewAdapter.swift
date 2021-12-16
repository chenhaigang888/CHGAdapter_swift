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
    func cellClass(collectionView:UICollectionView, at indexPath:IndexPath)->AnyClass?
    
    ///返回item的大小
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

public extension CHGCollectionViewCellModelProtocol {
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    func reusableView(collectionView:UICollectionView, supplementaryElementOfKind kind:String, atIndexPath indexPath:IndexPath) -> AnyClass?
    ///动态设置每个分区的EdgeInsets 不包括header和footer
    func sectionInset(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    ///动态设置每行的间距大小
    func minimumLineSpacing(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat
    ///动态设置每列的间距大小
    func minimumInteritemSpacingCollectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat
    ///动态设置某个分区头视图大小
    func referenceHeaderSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize
    ///动态设置某个分区尾视图大小
    func referenceFooterSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize
    
    func subDataKeyPath(_ indexPath:IndexPath,inCollectionView collectionView: UICollectionView) -> Any
}

public extension CHGCollectionViewSupplementaryElementModelProtocol {
    ///动态设置每个分区的EdgeInsets 不包括header和footer
    func sectionInset(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.sectionInset
        }
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    ///动态设置每行的间距大小
    func minimumLineSpacing(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGFloat {
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
    func referenceHeaderSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.headerReferenceSize
        }
        return CGSize.init(width: collectionView.frame.width, height: 30)
    }
    
    ///动态设置某个分区尾视图大小
    func referenceFooterSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
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
    
    open override func obtainCellClassWithCell(_ data: Any, collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> AnyClass? {
        if let cellModelProtocol = data as? CHGCollectionViewCellModelProtocol {
            return cellModelProtocol.cellClass(collectionView: collectionView, at: indexPath)
        } else if let cellModelProtocol = (data as AnyObject) as? CHGCollectionViewCellModelProtocol {
            return cellModelProtocol.cellClass(collectionView: collectionView, at: indexPath)
        }
        return super.obtainCellClassWithCell(data, collectionView: collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    open override func obtainSupplementaryElementClassWithCell(_ data: Any, collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: NSString, indexPath: IndexPath) -> AnyClass? {
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.reusableView(collectionView: collectionView, supplementaryElementOfKind: kind as String, atIndexPath: indexPath)
        } else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.reusableView(collectionView: collectionView, supplementaryElementOfKind: kind as String, atIndexPath: indexPath)
        }
        return super.obtainSupplementaryElementClassWithCell(data, collectionView: collectionView, viewForSupplementaryElementOfKind: kind, indexPath: indexPath)
    }
    
    ///动态设置每个分区的EdgeInsets 不包括header和footer
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let data = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionView.elementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section))
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol  {
            return supplementaryElementModelProtocol.sectionInset(collectionView: collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        } else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol  {
            return supplementaryElementModelProtocol.sectionInset(collectionView: collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        }
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.sectionInset
        }
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    ///动态设置每行的间距大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let data = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionView.elementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section))
        
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.minimumLineSpacing(collectionView:collectionView, layout: collectionViewLayout, atSection: section)
        } else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.minimumLineSpacing(collectionView:collectionView, layout: collectionViewLayout, atSection: section)
        }
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.minimumLineSpacing
        }
        return 0
    }
    
    ///动态设置每列的间距大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let data = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionView.elementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section))
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.minimumInteritemSpacingCollectionView(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        } else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.minimumInteritemSpacingCollectionView(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        }
        
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.minimumInteritemSpacing
        }
        return 0
    }
    
    
    //动态设置某个分区头视图大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let data = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionView.elementKindSectionHeader as NSString, indexPath: IndexPath.init(row: 0, section: section))
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.referenceHeaderSize(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        }else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.referenceHeaderSize(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        }
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.headerReferenceSize
        }
        return CGSize.init(width: collectionView.frame.width, height: 0)
        
    }
    
    ///动态设置每个Item的尺寸大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = cellDataWithIndexPath(indexPath,collectionView: collectionView)
        if let cellModelProtocol = data as? CHGCollectionViewCellModelProtocol {
            return cellModelProtocol.cellItemSize(collectionView: collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        } else if let cellModelProtocol = (data as AnyObject) as? CHGCollectionViewCellModelProtocol {
            return cellModelProtocol.cellItemSize(collectionView: collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        }
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.itemSize
        }
        return CGSize.init(width: 50, height: 50)
    }
    
    //动态设置某个分区尾视图大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let data = headerFooterDataWithrSupplementaryElementOfKind(kind: UICollectionView.elementKindSectionFooter as NSString, indexPath: IndexPath.init(row: 0, section: section))
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.referenceFooterSize(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        } else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol {
            return supplementaryElementModelProtocol.referenceFooterSize(collectionView: collectionView, layout: collectionViewLayout, atSection: section)
        }
        if collectionViewLayout.isKind(of: UICollectionViewFlowLayout.classForCoder()) {
            let layout:UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return layout.footerReferenceSize
        }
        return CGSize.init(width: collectionView.frame.width, height: 0)
        
    }
    
    open override func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        let data = self.adapterData.cellDatas![indexPath.section]
        if let supplementaryElementModelProtocol = data as? CHGCollectionViewSupplementaryElementModelProtocol {
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
        } else if let supplementaryElementModelProtocol = (data as AnyObject) as? CHGCollectionViewSupplementaryElementModelProtocol {
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
        
        return super.subDataKeyPath(indexPath, targetView: targetView)
    }
    
}

