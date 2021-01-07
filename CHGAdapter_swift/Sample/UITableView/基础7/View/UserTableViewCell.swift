//
//  UserTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/7.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class UserTableViewCell: CHGTableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fridentView: FriendView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.protocolsVMO?.append(ViewMappingObject(view: fridentView, mapping: [.CellType : \User.friends]))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let user:User = self.model as? User else {
            return
        }
        name.text = user.name
    }
    
}
