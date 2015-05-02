//
//  ViewController.swift
//  userDefault
//
//  Created by Eular on 15/4/19.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchBtu: UISwitch!
    
    var ud: NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ud = NSUserDefaults.standardUserDefaults()
        switchBtu.on = ud.boolForKey("showTips")
        
        if switchBtu.on {
            UIAlertView(title: "小贴士", message: "世界再吵，也要保持心情大好", delegate: nil, cancelButtonTitle: "好的").show()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchChanged(sender: AnyObject) {
        ud.setBool(switchBtu.on, forKey: "showTips")
    }

}

