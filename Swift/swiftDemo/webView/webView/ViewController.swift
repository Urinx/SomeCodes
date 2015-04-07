    //
//  ViewController.swift
//  webView
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var wv: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnGoTapped(sender: AnyObject) {
        if !urlText.text.isEmpty {
            var url = urlText.text
            
            if !url.hasPrefix("http://") {
                url = "http://" + url
            }
            
            wv.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
            urlText.resignFirstResponder()
        }
        else {
            var alert = UIAlertView(title: "地址栏为空", message: "请输入正确的地址", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
    }

}

