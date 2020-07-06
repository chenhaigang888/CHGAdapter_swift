//
//  AlbumDescTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class AlbumDescTableViewHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var albumDescTextView: UITextView!
  
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        guard let model:AlbumDesc = self.model as? AlbumDesc else { return }
        albumDescTextView.text = model.desc
    }
    
}
