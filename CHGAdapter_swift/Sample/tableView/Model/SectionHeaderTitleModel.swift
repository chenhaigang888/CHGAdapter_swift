//
//  SectionHeaderTitleModel.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class SectionHeaderTitleModel: NSObject {

    var title:String?
    var headerClass:String?
    
    
    init(title:String?,headerClass:String?) {
        super.init()
        self.title = title
        self.headerClass = headerClass
    }
    
}

extension SectionHeaderTitleModel:CHGTableViewHeaderFooterModelProtocol {
    func getHeaderFooterClass() -> String {
        return headerClass!
    }
    
    func getHeaderFooterHeigh() -> CGFloat {
        return 30
    }
    
    
}
