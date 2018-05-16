//
//  CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 回调
typealias CHGCallBack = (_ data:AnyObject?) -> Void

/// 事件传输block target
typealias CHGEventTransmissionBlock = (_ target:AnyObject,_ params:AnyObject,_ tag:NSInteger,_ callBack:CHGCallBack?) ->AnyObject?

/// tableViewDidSelectRow 回调
typealias CHGTableViewDidSelectRowBlock = (UITableView,NSIndexPath,AnyObject)->Void

protocol CHGTableViewAdapterProtocol:UITableViewDelegate,UITableViewDataSource {
    
    func obtainCellNameWithCell(_ data:AnyObject ,tableView:UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> NSString
    
    func obtainHeaderNameWithHeader(_ data:AnyObject,tableView:UITableView, viewForHeaderInSection section:NSInteger) -> NSString
    
    func obtainFooterNameWithFooter(_ data:AnyObject,tableView:UITableView, viewForFooterInSection section:NSInteger) -> NSString
}

class CHGTableViewAdapter: NSObject,CHGTableViewAdapterProtocol {
    
    var cellName:NSString? = ""
    var headerName:NSString? = ""
    var footerName:NSString? = ""
    var adapterData:CHGTableViewAdapterData?
    var rowsOfSectionKeyName:NSString?
    
    func obtainCellNameWithCell(_ data: AnyObject, tableView: UITableView, cellForRowAtIndexPath cell: IndexPath) -> NSString {
        return self.cellName!;
    }
    
    func obtainHeaderNameWithHeader(_ data: AnyObject, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> NSString {
        return self.headerName!;
    }
    
    func obtainFooterNameWithFooter(_ data: AnyObject, tableView: UITableView, viewForFooterInSection section: NSInteger) -> NSString {
        return self.footerName!;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let cellDatas = self.adapterData?.cellDatas
        if (self.rowsOfSectionKeyName != nil) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellDatas = self.adapterData?.cellDatas
        if cellDatas?.count == 0 {
            return 0;
        }
        
        if (self.rowsOfSectionKeyName != nil && (!(cellDatas![section] is NSArray))) {
            return ((cellDatas![section] as AnyObject).value(forKey: self.rowsOfSectionKeyName! as String) as! NSArray).count
        }
        let cellData = cellDatas![section]
        if cellData is NSArray {
            return (cellData as AnyObject).count
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
    
    func fileIsExit(_ fileName:String) -> Bool {
        let xibFile = Bundle.main.path(forResource: fileName, ofType: "nib")
        return xibFile != nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath)
        let identifier = self.obtainCellNameWithCell(cellData!, tableView: tableView, cellForRowAtIndexPath: indexPath)
        if identifier.length == 0 {
            return UITableViewCell()
        }
        if self.fileIsExit(identifier as String) {
            tableView.register(UINib (nibName: identifier as String, bundle: nil), forCellReuseIdentifier: identifier as String)
        } else {
            let NameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let classAllNameClass:AnyClass = NSClassFromString("\(NameSpace).\(identifier)")!
            tableView.register(classAllNameClass, forCellReuseIdentifier: identifier as String)
        }
       
        let cell:CHGTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier as String, for: indexPath) as! CHGTableViewCell
        cell.eventTransmissionBlock = tableView.eventTransmissionBlock
        cell.cellForRow(atIndexPath: indexPath, tableView: tableView, data: cellData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGTableViewHeaderFooterViewType.HeaderType, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGTableViewHeaderFooterViewType.FooterType, viewForHeaderInSection: section)
    }
    
    func tableview(_ tableView:UITableView,tableViewHeaderFooterViewType type:CHGTableViewHeaderFooterViewType,viewForHeaderInSection section:NSInteger) -> UIView? {
        //获取headerFooter的Item 数据
        let headerFooterDatas:NSArray? =
            type == CHGTableViewHeaderFooterViewType.HeaderType
                ?
                    self.adapterData?.headerDatas
                :
                    self.adapterData?.footerDatas
        var headerFooterData:AnyObject?
        if headerFooterDatas != nil && headerFooterDatas?.count != 0 {
            if section >= (headerFooterDatas?.count)! {
                return nil
            }
            headerFooterData = headerFooterDatas?[section] as AnyObject
        }
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
        if self.fileIsExit(identifier as String) {
            tableView.register(UINib(nibName: identifier as String, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier as String)
        } else {
            let NameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let classAllNameClass:AnyClass = NSClassFromString("\(NameSpace).\(identifier)")!
            tableView.register(classAllNameClass, forHeaderFooterViewReuseIdentifier: identifier as String)
        }
        let view:CHGTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier as String) as! CHGTableViewHeaderFooterView
        view.eventTransmissionBlock = tableView.eventTransmissionBlock
        view.headerFooter(headerFooterForSection: section, tableView: tableView, data: headerFooterData!, type: type)
        return view
    }
    
}
