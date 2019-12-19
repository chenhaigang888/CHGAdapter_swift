//
//  CompanyCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class CompanyCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        let model:Company = self.reusableViewData as! Company
        title.text = model.name
    }
}
