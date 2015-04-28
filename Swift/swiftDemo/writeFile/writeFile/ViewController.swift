//
//  ViewController.swift
//  writeFile
//
//  Created by Eular on 15/4/19.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var filepath: UILabel!
    @IBOutlet weak var editText: UITextView!
    
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        
        if documentPath.count > 0 {
            url = NSURL(fileURLWithPath: "\(documentPath[0])/tmp.txt")
            filepath.text = "\(url!)"
        }
        
        // 读取文件
        if let data = NSData(contentsOfFile: url!.path!) {
            var str = NSString(data: data, encoding: NSUTF8StringEncoding)
            editText.text = "\(str!)"
        }
        
        // 或者
        // var str = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        editText.resignFirstResponder()
    }

    @IBAction func saveFile(sender: AnyObject) {
        var data = NSMutableData()
        var text = editText.text
        data.appendData(text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        data.writeToFile(url!.path!, atomically: true)
    }

}

