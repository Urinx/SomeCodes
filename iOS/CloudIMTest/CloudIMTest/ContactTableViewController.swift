//
//  ContactTableViewController.swift
//  CloudIMTest
//
//  Created by Eular on 10/9/15.
//  Copyright © 2015 Eular. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = UILabel()
        lb.text = "1位联系人"
        lb.textAlignment = .Center
        lb.textColor = UIColor.grayColor()
        lb.frame = CGRectMake(0, 0, view.bounds.width, 60)
        tableView.tableFooterView = lb
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {
            let chatVC = RCConversationViewController()
            chatVC.targetId = WeixinId
            chatVC.userName = "Ai"
            chatVC.conversationType = .ConversationType_PRIVATE
            chatVC.title = "Ai"
            self.navigationController?.pushViewController(chatVC, animated: true)
            self.tabBarController?.tabBar.hidden = true
        }
    }
}
