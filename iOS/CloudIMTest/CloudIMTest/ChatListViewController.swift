//
//  ViewController.swift
//  CloudIMTest
//
//  Created by Eular on 10/7/15.
//  Copyright © 2015 Eular. All rights reserved.
//

import UIKit

class ChatListViewController: RCConversationListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("isLogined") {
            NSNotificationCenter.defaultCenter().addObserver(self, selector:"hasLogined:", name: hasLoginedNotification, object: nil)
            self.presentViewController(LoginViewController(), animated: false, completion: nil)
        } else {
            self.connectServer()
        }
    }
    
    func hasLogined(notification: NSNotification) {
        self.connectServer()
    }
    
    func connectServer() {
        let weixinUser = NSUserDefaults.standardUserDefaults().objectForKey("weixinUser")
        var userId = weixinUser?.objectForKey("openid") as! String
        let name = weixinUser?.objectForKey("nickname") as! String
        let portrait = weixinUser?.objectForKey("headimgurl") as! String
        var token = ""
        
        if userId == WeixinId {
            token = WeiToken
        } else {
            token = TestToken
            userId = TestId
        }
        
        RCIM.sharedRCIM().initWithAppKey(RCIMAppKey)
        RCIM.sharedRCIM().connectWithToken(token, success: { (_) -> Void in
            print("连接成功")
            let currentUser = RCUserInfo(userId: userId, name: name, portrait: portrait)
            RCIMClient.sharedRCIMClient().currentUserInfo = currentUser
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.setDisplayConversationTypes([
                    RCConversationType.ConversationType_APPSERVICE.rawValue,
                    RCConversationType.ConversationType_CHATROOM.rawValue,
                    RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                    RCConversationType.ConversationType_DISCUSSION.rawValue,
                    RCConversationType.ConversationType_GROUP.rawValue,
                    RCConversationType.ConversationType_PRIVATE.rawValue,
                    RCConversationType.ConversationType_PUBLICSERVICE.rawValue,
                    RCConversationType.ConversationType_SYSTEM.rawValue
                    ])
                self.refreshConversationTableViewIfNeeded()
            })
            
            }, error: { (code: RCConnectErrorCode) -> Void in
                print("连接失败: \(code)")
            }) { () -> Void in
                print("Token错误，或失效")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshConversationTableViewIfNeeded()
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        let chatVC = RCConversationViewController()
        chatVC.targetId = model.targetId
        chatVC.userName = model.conversationTitle
        chatVC.conversationType = .ConversationType_PRIVATE
        chatVC.title = model.conversationTitle
        self.navigationController?.pushViewController(chatVC, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }

    @IBAction func popOver(sender: UIBarButtonItem) {
        guard var frame = sender.valueForKey("view")?.frame else { return }
        frame.origin.y += 30
        KxMenu.showMenuInView(self.view, fromRect: frame, menuItems: [
            KxMenuItem("发起群聊", image: UIImage(named: "contacts_add_newmessage"), target: self, action: nil),
            KxMenuItem("添加朋友", image: UIImage(named: "contacts_add_friend"), target: self, action: nil),
            KxMenuItem("扫一扫", image: UIImage(named: "contacts_add_scan"), target: self, action: nil),
            KxMenuItem("收钱", image: UIImage(named: "contacts_add_money"), target: self, action: nil)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

