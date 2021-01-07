//
//  FriendView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/7.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit



class FriendView: CHGBaseView {

    
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 100, height: 50)
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self .addSubview(self.collectionView)
    }
    

    
    override func cellWillAppear() {
        super.cellWillAppear()
        collectionView.cellDatas = [self.model]
        collectionView.reloadData()
        
        
    }

}
