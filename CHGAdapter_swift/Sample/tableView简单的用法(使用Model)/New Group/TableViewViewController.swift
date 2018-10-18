//
//  TableViewViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TableViewViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.headerDatas = headerDatas
        tableView?.cellDatas = cellDatas
        tableView?.footerDatas = footerDatas
        tableView?.eventTransmissionBlock = eventTransmissionBlock
        tableView?.scrollListener?.scrollViewDidScrollBlock = {(scrollView)in
            print("scrollView.contentOffset.y:\(scrollView.contentOffset.y)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var eventTransmissionBlock:CHGEventTransmissionBlock = {
        {[weak self](target:Any,param:Any,tag:NSInteger,callback:CHGCallBack?) in
            if target is TVInputTextTableViewCell { //TVInputTextTableViewCell 中返回的事件
                let dic:NSDictionary = param as! NSDictionary
                let indexPath:IndexPath = dic.object(forKey: "indexPath") as! IndexPath
                let inputText:String = dic.object(forKey: "inputText") as! String
                print("第\(indexPath.row)行输入内容为：\(inputText)")
            } else if target is TVSubmitHeaderFooterView { //TVSubmitHeaderFooterView中传回的事件
                if tag == 0 {//左边按钮点击
                    self?.leftBtnTap()
                } else if tag == 1 {//右边按钮点击
                    self?.rightBtnTap()
                }
            } else if target is TVSuccHeaderFooterView {
                self?.succPageTap()
            }
            return nil
        }
    }()
    
    func succPageTap() -> Void {
        //重新显示登录按钮
        tableView?.footerDatas = footerDatas
        tableView?.reloadData()
    }
    
    func rightBtnTap() -> Void {
        let section0:NSArray = self.cellDatas.object(at: 0) as! NSArray
        let itm1:TVInputTextModel = section0[0] as! TVInputTextModel
        let itm2:TVInputTextModel = section0[1] as! TVInputTextModel
        itm1.inputText = ""
        itm2.inputText = ""
        tableView?.reloadData()
    }
    
    
    func leftBtnTap() -> Void {
        //模拟登录
        let section0:NSArray = self.cellDatas.object(at: 0) as! NSArray
        let itm1:TVInputTextModel = section0[0] as! TVInputTextModel
        let itm2:TVInputTextModel = section0[1] as! TVInputTextModel
        
        let username:NSString = itm1.inputText as NSString
        let password:NSString = itm2.inputText as NSString
        
        if username.length == 0{
            itm1.placeholder = "用户名不能为空"
            tableView?.reloadData()
            return
        }
        if password.length == 0 {
            itm2.placeholder = "密码不能为空"
            tableView?.reloadData()
            return
        }
        tableView?.footerDatas = [TVSuccModel.init(title: "登录成功！")]
        tableView?.reloadData()
    }
    
    lazy var headerDatas:NSArray = {
        let headerDatas =
            [
                TVTitleModel.init(title: "演示输入框、按钮事件传输")
            ]
        return headerDatas as NSArray
    }()
    
    lazy var cellDatas:NSArray = {
        let cellDatas =
            [
                [
                    TVInputTextModel.init(placeholder: "用户名"),
                    TVInputTextModel.init(placeholder: "密码")
                ]
            ]
        return cellDatas as NSArray
    }()
    
    
    lazy var footerDatas:NSArray = {
        let footerDatas =
            [
                TVSubmitModel.init(leftBtnText: "登录", rightBtnText: "清空")
            ]
        return footerDatas as NSArray
    }()

}
