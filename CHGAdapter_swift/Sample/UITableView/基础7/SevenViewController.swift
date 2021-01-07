//
//  SevenViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/7.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class SevenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellDatas = [createUsers()]
    }


    func createUsers() -> [User] {
        var users = [User]()
        for i in 0...100 {
            var friends = [Friend]()
            for j in 0...10 {
                friends.append(Friend(name: "好友：\(j)", sex: 1))
            }
            users.append(User(name: "名字:\(i)", friends: friends))
        }
        return users
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
