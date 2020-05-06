//
//  CompanyHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class CompanyHeaderFooterView: CHGTableViewHeaderFooterView {
    
    lazy var title:UILabel = {[weak self]()in
        let title = UILabel.init()
        title.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        return title
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func headerFooterViewWillAppearWithType(type: CHGTableViewHeaderFooterViewType) {
//        super.headerFooterViewWillAppearWithType(type: type)
//        let model:Company = self.headerFooterData as! Company
//        title.text = model.name
//    }
    
    override func headerFooterViewWillAppear(with type: CHGTableViewHeaderFooterViewType) {
        super.headerFooterViewWillAppear(with: type)
        let model:Company = self.model as! Company
        title.text = model.name
    }
}
