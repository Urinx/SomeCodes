//
//  ViewController.swift
//  urlScheme
//
//  Created by Eular on 15/4/19.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openBrowser(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.baidu.com")!)
    }

    @IBAction func openTel(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://10086")!)
    }
    
    @IBAction func openEmail(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto://1336006643@qq.com")!)
    }
    
    @IBAction func openSMS(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "sms://10086")!)
    }

    @IBAction func openScheme(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "test://bilibili?a=123&b=456")!)
    }
    
}

