//
//  ViewController.swift
//  http
//
//  Created by Eular on 15/4/22.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tv: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var html = NSString(contentsOfURL: NSURL(string: "http://www.baidu.com")!, encoding: NSUTF8StringEncoding, error: nil)
        var html2 = NSString(data: NSData(contentsOfURL: NSURL(string: "http://www.baidu.com")!)!, encoding: NSUTF8StringEncoding)
        
        // 同步
        var resp: NSURLResponse?
        var html3 = NSString(data: NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!), returningResponse: &resp, error: nil)!, encoding: NSUTF8StringEncoding)
        
        // 异步
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!), queue: NSOperationQueue()) {
            (resp: NSURLResponse!, data: NSData!, err: NSError!) -> Void in
            if let e = err {
                println("连接错误")
            } else {
                // 在主线程操作
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.tv.text = "\(resp!)"
                })
            }
        }
        
        // println(html3)
        // println(resp)
        
        // POST
        var req = NSMutableURLRequest(URL: NSURL(string: "http://www.baidu.com")!)
        req.HTTPMethod = "POST"
        req.HTTPBody = NSString(string: "id=1234").dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue()) {
            (resp: NSURLResponse!, data: NSData!, err: NSError!) -> Void in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

