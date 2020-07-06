//
//  AlbumTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/3.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


class AlbumTableViewHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        
        guard let model:Album = self.model as? Album else { return }
        nameLabel.text = model.name
        createTimeLabel.text = model.createTime
    }

}
