//
//  CHGCollectionViewAdapterData.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGCollectionViewAdapterData: NSObject,CHGAdapterDataProtocol {
    open var cellDatas: [Any]?
    
    open var headerDatas: [Any]?
    
    open var footerDatas: [Any]?
    
    open var customData: Any?
}
