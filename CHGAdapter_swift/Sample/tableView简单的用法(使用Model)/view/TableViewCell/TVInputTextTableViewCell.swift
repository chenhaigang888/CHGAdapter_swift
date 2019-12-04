//
//  TVInputTextTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVInputTextTableViewCell: CHGTableViewCell {
    
    @IBOutlet weak var textField:UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: Any?) {
        super.cellForRow(atIndexPath: indexPath, tableView: tableView, data: data)
        let inputTextModel:TVInputTextModel = data as! TVInputTextModel
        self.textField?.placeholder = inputTextModel.placeholder
        self.textField?.text = inputTextModel.inputText
    }
    
    @IBAction func textFieldTextChanged(sender:AnyObject)->Void {
        let inputTextModel:TVInputTextModel = self.cellData as! TVInputTextModel
        inputTextModel.inputText = (self.textField?.text)!
        let param = ["indexPath":self.indexPath ?? IndexPath.init(),
                     "inputText":textField?.text ?? ""
                    ] as [String : Any]
        _ = self.eventTransmissionBlock!(self,param as AnyObject,0,{(data) in
            
        })
    }
    
}
