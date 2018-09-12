//
//  CHGSubDataOfKeyPathDelegate.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import Foundation
import UIKit

public protocol CHGSubDataOfKeyPathDelegate {
    func subDataKeyPath(_ indexPath:IndexPath, targetView:UIScrollView ) -> Any?
}
