//
//  WeekCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class WeekCollectionViewCell: CHGCollectionViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let week:Week = self.model as? Week else { return }
        name.text = week.weekDesc()
    }
}
