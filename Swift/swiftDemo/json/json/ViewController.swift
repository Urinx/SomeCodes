//
//  ViewController.swift
//  json
//
//  Created by Eular on 15/4/21.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 读取本地json文件
        var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("data", withExtension: "json")!)!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        var user: AnyObject? = json?.objectForKey("user")
        println(user!)
        
        // 字典转data
        var dict = ["aaa":"1234", "bbb":456]
        var jsonData = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.allZeros, error: nil)
        var str = NSString(data: jsonData!, encoding: NSUTF8StringEncoding)
        println(str!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

