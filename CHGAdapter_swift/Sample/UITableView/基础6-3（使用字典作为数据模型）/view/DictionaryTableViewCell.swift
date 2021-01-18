//
//  DictionaryTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/18.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class DictionaryTableViewCell: CHGTableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let dict:Dictionary = model as? Dictionary<String, Any> else { return }
        
        nameLabel.text = dict["text"] as? String
    }
}
