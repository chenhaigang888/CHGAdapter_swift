//
//  Group.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/8/24.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

//"groupId":"1",
//"groupName":"我的好友",
//"count":"3",
//"test"
class Group: NSObject {

    var groupId:String?
    var groupName:String?
    var count:String?
    var test:NSArray?
    
    init(groupId:String,groupName:String,count:String,test:NSArray) {
        super.init()
        self.groupId = groupId
        self.groupName = groupName
        self.count = count
        self.test = test
    }
    
}

//["id":"3","name":"王五1","sigin":"签名1","icon":"img_qs_50x50"],
class Test: NSObject {
    var id:String?
    var name:String?
    var sigin:String?
    var icon:String?
    
    init(id:String,name:String,sigin:String,icon:String) {
        super.init()
        self.id = id
        self.name = name
        self.sigin = sigin
        self.icon = icon
    }
    
}
