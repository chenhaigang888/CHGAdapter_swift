//
//  WeekTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class WeekTableViewCell: CHGTableViewCell {

    @IBOutlet weak var name: UILabel!
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
        guard let week:Week = self.cellData as? Week else { return }
        name.text = week.weekDesc()
    }
}
