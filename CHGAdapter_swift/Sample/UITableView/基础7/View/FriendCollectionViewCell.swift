//
//  FriendCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/7.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: CHGCollectionViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func cellWillAppear() {
        super.cellWillAppear()
        
        guard let friend:Friend = self.model as? Friend else {
            return
        }
        name.text = friend.name
    }
}
