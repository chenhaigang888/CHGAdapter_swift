//
//  BaseCV_4_ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class BaseCV_4_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
          super.viewDidLoad()
          title = "基础4（cell、headerFooterView中的事件传递到ViewController中）"
          collectionView.headerDatas = [createOrderGroup()]
          collectionView.cellDatas = [createOrders()]
          collectionView.setEventTransmissionBlock(eventTransmissionBlock: handleEventTransmissionBlock())
          collectionView.setEmptyDataShow("无数据", imageName: "")
      }
    
      
      /// 创建订单数据
      /// - Returns: description
      func createOrders() -> [Order] {
          var orders = [Order]()
          for i in 0...10 {
              orders.append(Order.init(id: i, orderNO: "\(i)", createTime: "2020-7-6", amount: "\(100+i)"))
          }
          return orders
          
      }
      
      /// 创建Header数据
      /// - Returns: description
      func createOrderGroup() -> OrderGroup {
          return OrderGroup.init(desc: "2020年6月", btnText: "全部删除")
      }
      
      /// 处理cell、headerFooterView中的事件
      /// - Returns: description
      func handleEventTransmissionBlock() -> CHGEventTransmissionBlock {
          return { [weak self](target, params, tag, callBack) -> Any? in
              if target is OrderCollectionViewCell {//cell中的事件
                  switch OrderAction.init(rawValue: tag) {
                  case .refund:
                      return self?.refund(with: target, params: params, tag: tag, callBack: callBack)
                  case .conform:
                      return self?.conform(with: target, params: params, tag: tag, callBack: callBack)
                  default:
                      break
                  }
              } else if target is OrderGroupCollectionReusableView {//header中的事件
                  if tag == 0 {
                      return self?.deleteAllOrders(with: target, params: params, tag: tag, callBack: callBack)
                  }
              }
              return nil
          }
      }
      
      /// 处理cell中传递出来的退货操作
      /// - Parameters:
      ///   - target: target description
      ///   - params: params description
      ///   - tag: tag description
      ///   - callBack: callBack description
      /// - Returns: description
      func refund(with target:Any?, params:Any?, tag:Int, callBack:CHGCallBack?) -> Any? {
          guard let model:Order = params as? Order else { return nil }
          print("处理退货操作  订单id:\(model.id)   订单号：\(model.orderNO)   订单金额：\(model.amount)   创建时间：\(model.createTime)")
          return nil;
      }
      
      
      /// 处理cell中传递出来的确认收货操作
      /// - Parameters:
      ///   - target: target description
      ///   - params: params description
      ///   - tag: tag description
      ///   - callBack: callBack description
      /// - Returns: description
      func conform(with target:Any?, params:Any?, tag:Int, callBack:CHGCallBack?) -> Any? {
          guard let model:Order = params as? Order else { return nil }
          print("处理确认收货操作  订单id:\(model.id)   订单号：\(model.orderNO)   订单金额：\(model.amount)   创建时间：\(model.createTime)")
          _ = callBack?(true)//告诉cell中处理完成
          return nil;
      }
      
      /// 删除所有数据的操作
      /// - Parameters:
      ///   - target: target description
      ///   - params: params description
      ///   - tag: tag description
      ///   - callBack: callBack description
      /// - Returns: description
      func deleteAllOrders(with target:Any?, params:Any?, tag:Int, callBack:CHGCallBack?) -> Any? {
          collectionView.headerDatas = []
          collectionView.cellDatas = []
          collectionView.reloadData()
          return nil;
      }

}
