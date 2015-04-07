//
//  ViewController.swift
//  alert
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var alert: UIAlertController!
    var actionSheet: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button1 = UIButton.buttonWithType(.System) as UIButton
        button1.frame = CGRectMake(30, 50, self.view.frame.width - 60, 100)
        button1.setTitle("Alert", forState: .Normal)
        button1.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
        button1.tag = 1
        
        let button2 = UIButton.buttonWithType(.System) as UIButton
        button2.frame = CGRectMake(30, 150, self.view.frame.width - 60, 100)
        button2.setTitle("Action Sheet", forState: .Normal)
        button2.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
        button2.tag = 2
        
        // 定义菜单按钮
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action: UIAlertAction!) -> Void in
            println("you choose ok")
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
            (action: UIAlertAction!) -> Void in
            println("you choose delete")
        }
        
        // 定义一个 Alert
        alert = UIAlertController(title: "simple alert", message: "this is a simple alert", preferredStyle: .Alert)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addAction(deleteAction)
        
        // 定义一个 ActionSheet
        actionSheet = UIAlertController(title: "simple action sheet", message: "this is a simple action sheet", preferredStyle: .ActionSheet)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(okAction)
        actionSheet.addAction(deleteAction)
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 响应按钮点击事件
    func buttonAction(sender: UIButton) {
        let num = sender.tag
        switch num {
        case 1:
            self.presentViewController(alert, animated: true, completion: nil)
        case 2:
            self.presentViewController(actionSheet, animated: true, completion: nil)
        default:
            break
        }
    }
}

