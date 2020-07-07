//
//  SingerDescCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class SingerDescCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var textView: UITextView!
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:Singer = self.model as? Singer else { return }
        textView.text = model.desc
    }
    
}
