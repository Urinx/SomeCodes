//
//  TodayViewController.swift
//  todayWidget
//
//  Created by Eular on 15/4/21.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var tLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSizeMake(320, 80)
        self.updateClocks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func updateClocks() {
        var time = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        tLabel.text = formatter.stringFromDate(time)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let context = extensionContext {
            context.openURL(NSURL(string: "http://www.baidu.com")!, completionHandler: nil)
        }
    }
    
}
