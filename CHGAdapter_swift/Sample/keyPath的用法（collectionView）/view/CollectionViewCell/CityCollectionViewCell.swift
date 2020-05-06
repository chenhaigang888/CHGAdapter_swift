//
//  CityCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CityCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var title:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func cellForRowAt(indexPath: IndexPath, targetView: UIView, model: Any, eventTransmissionBlock: CHGEventTransmissionBlock?) {
        super.cellForRowAt(indexPath: indexPath, targetView: targetView, model: model, eventTransmissionBlock: eventTransmissionBlock)
        let model:CityModel = model as! CityModel
        title?.text = model.name
    }
}
