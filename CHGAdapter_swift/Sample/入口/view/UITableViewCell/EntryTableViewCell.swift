//
//  EntryTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class EntryTableViewCell: CHGTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
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
        guard let model:Entry = self.model as? Entry else { return }
        titleLabel.text = model.title
    }
    
}
