//
//  CollectionViewViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CollectionViewViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var inputText:String = ""//记录输入内容
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 150, height: 150)
        layout.headerReferenceSize = CGSize.init(width:UIScreen.main.bounds.width , height: 30)
        layout.footerReferenceSize = CGSize.init(width:UIScreen.main.bounds.width , height: 30)
        layout.minimumLineSpacing = 10//行间距
        layout.minimumInteritemSpacing = 10//列间距
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.collectionViewLayout = layout
        
        collectionView.cellDatas = cellDatas
        collectionView.headerDatas = headerDatas
        collectionView.footerDatas = footerDatas
        collectionView.collectionViewDidSelectItemAtIndexPathBlock = collectionViewDidSelectItemAtIndexPathBlock
        collectionView.eventTransmissionBlock = eventTransmissionBlock
        collectionView?.scrollListener?.scrollViewDidScrollBlock = {(scrollView)in
            print("scrollView.contentOffset.y:\(scrollView.contentOffset.y)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// collectionViewCell 被点击
    lazy var collectionViewDidSelectItemAtIndexPathBlock:CHGCollectionViewDidSelectItemAtIndexPathBlock = {
        {(collectionView:UICollectionView,indexPath:IndexPath,itemData:AnyObject) in
            
        }
    }()
    
    ///接收collectionView中的各种View、Adapter的事件传输。比如cell中有一个按钮点击按钮后可以通过 cell的eventTransmissionBlock将点击事件传输到这里进行处理,header、footer 等View的事件传输类似
    lazy var eventTransmissionBlock:CHGEventTransmissionBlock = {
        {[weak self](target:AnyObject,param:AnyObject,tag:NSInteger,callBack:CHGCallBack?) in
            if target is CVInputTextCollectionViewCell { //CVInputTextCollectionViewCell 中返回的输入内容
                self?.inputText = param as! String
                print("输入内容为:\(String(describing: self?.inputText))")//
            } else if target is CVSimulationDownCollectionViewCell {//模拟下载返回的开始下载
                self?.simulationDownTask(param: param, callBack: callBack)
            }
            return nil
        }
    }()
    
    //模拟下载任务
    func simulationDownTask(param:AnyObject,callBack:CHGCallBack?) -> Void {
        let simulationDownload:CVSimulationDownModel = param as! CVSimulationDownModel
        //模拟下载
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                callBack!("开始下载" as AnyObject)
            }
            for i in 0...100 {
                sleep(1)
                DispatchQueue.main.async {
                    print("----模拟下载:\(String(describing: simulationDownload.url))---进度：\(i)---")
                    callBack!("下载进度：\(i)%" as AnyObject)
                }
            }
            DispatchQueue.main.async {
                callBack!("下载完成100%" as AnyObject)
            }
        }
    }
    
    //-------------------------------------------------------------------以下为构造数据-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    /// 构造cell数据
    lazy var cellDatas:NSArray = {
        let cellDatas =
            [
                [                                               //第一个section的数据，是一个数组
                    CVInputTextModel.init(),
                    CVSimulationDownModel.init(url: "http://www.baidu.com"),
                    CVTitleModel.init(name: "section1 cell1"),
                    CVTitleModel.init(name: "section1 cell2"),
                    CVTitleModel.init(name: "section1 cell3"),
                    CVTitleModel.init(name: "section1 cell4"),
                    CVTitleModel.init(name: "section1 cell5"),
                    CVTitleModel.init(name: "section1 cell6"),
                    CVTitleModel.init(name: "section1 cell7")
                ],
                [                                               //第二个section的数据，是一个数组
                    CVTitleModel.init(name: "section2 cell1"),
                    CVTitleModel.init(name: "section2 cell2"),
                    CVTitleModel.init(name: "section2 cell3"),
                    CVTitleModel.init(name: "section2 cell4"),
                    CVTitleModel.init(name: "section2 cell5"),
                    CVTitleModel.init(name: "section2 cell6"),
                    CVTitleModel.init(name: "section2 cell7")
                ],
                CVTitleModel.init(name: "section2 cell7")       //第三个section,是一个对象
            ] as [Any]
        return cellDatas as NSArray
    }()
    
    /// 构造header数据
    lazy var headerDatas:NSArray = {
        let headerDatas =
            [
                CVHeaderModel.init(name: "section header view 1",bgColor: UIColor.red),
                CVHeaderModel.init(name: "section header view 2",bgColor: UIColor.red),
                CVHeaderModel.init(name: "section header view 2",bgColor: UIColor.red)
            ]
        return headerDatas as NSArray
    }()
    
    /// 构造footer数据
    lazy var footerDatas:NSArray = {
        let footerDatas =
            [
                CVHeaderModel.init(name: "section footer view 1",bgColor: UIColor.green),
                CVHeaderModel.init(name: "section footer view 2",bgColor: UIColor.green),
                CVHeaderModel.init(name: "section footer view 2",bgColor: UIColor.green)
            ]
        return footerDatas as NSArray
    }()
    
    
    
}
