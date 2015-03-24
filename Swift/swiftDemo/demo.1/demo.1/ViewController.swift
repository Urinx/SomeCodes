//
//  ViewController.swift
//  demo.1
//
//  Created by Eular on 15-3-20.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var num: UITextField
    
    @IBOutlet var qrcode: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        num.resignFirstResponder()
    }

    
    @IBAction func confirmClick(sender: AnyObject) {
        num.resignFirstResponder()
        if let n = num.text.toInt() {
            if n % 2 == 0 {
                qrcode.image = UIImage(named: "IMG_0473.JPG")
            } else {
                qrcode.image = UIImage(named: "qrcode_for_gh_25b159f59282_430.jpg")
            }
        }
        
    }

}

