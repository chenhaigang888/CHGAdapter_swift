//
//  Utils.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/4/28.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import Foundation

class Utils: NSObject {
    ///判断文件是否存在
    open class func fileIsExit(moduleName:String,fileName:String) -> Bool {
        guard Bundle.main.path(forResource: fileName, ofType: "nib") != nil else {
            let url = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
            let urlPodName = url!.appendingPathComponent(moduleName)
            let urlPodNameFramework = urlPodName.appendingPathExtension("framework")
            let bundle = Bundle.init(url: urlPodNameFramework)
            let xibFile_ = bundle?.path(forResource: fileName, ofType: "nib")
            return xibFile_ != nil
        }
        return true
    }
    
    ///获取简单的类名
    open class func getShortClassName(anyClass:AnyClass) -> String {
        return String(NSStringFromClass(anyClass).split(separator: ".").last!)
    }
    
    open class func getBundle(anyClass:AnyClass)->Bundle {
        let url = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        let urlPodName = url!.appendingPathComponent(getModuleName(anyClass: anyClass))
        let urlPodNameFramework = urlPodName.appendingPathExtension("framework")
        let bundle = Bundle.init(url: urlPodNameFramework)
        return bundle ?? Bundle.main
    }
    
    open class func getNibName(moduleName:String, nibName:String)->String? {
        guard let xibFile = Bundle.main.path(forResource: nibName, ofType: "nib")  else {
            let url = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
            let urlPodName = url!.appendingPathComponent(moduleName)
            let urlPodNameFramework = urlPodName.appendingPathExtension("framework")
            let bundle = Bundle.init(url: urlPodNameFramework)
            guard let xibFile = bundle?.path(forResource: nibName, ofType: "nib") else { return nil }
            return xibFile
        }
        return xibFile
    }
    
    ///获取模块名称
    open class func getModuleName(anyClass:AnyClass) -> String {
        return String(NSStringFromClass(anyClass).split(separator: ".").first!)
    }
}
