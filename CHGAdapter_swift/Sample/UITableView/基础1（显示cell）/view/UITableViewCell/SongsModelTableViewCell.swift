//
//  SongsModelTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/3.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class SongsModelTableViewCell: CHGTableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
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
        guard let model:SongsModel = self.model as? SongsModel else { return }
        nameLabel.text = model.name
    }
    
}
