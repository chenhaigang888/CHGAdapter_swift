//
//  AlbumCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class AlbumCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var nameLabel: UILabel!
   
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:Album = self.model as? Album else { return }
        nameLabel.text = model.name
    }
}
