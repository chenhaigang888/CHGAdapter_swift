//
//  AlbumDescCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class AlbumDescCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var nameTextView: UITextView!
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:AlbumDesc = self.model as? AlbumDesc else { return }
        nameTextView.text = model.desc
    }
    
}
