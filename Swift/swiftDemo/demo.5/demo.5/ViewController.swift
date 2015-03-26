//
//  ViewController.swift
//  demo.5
//
//  Created by Eular on 15-3-25.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
                            
    @IBOutlet var bgImg: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func share(forServiceType shareMethod: NSString!) {
        var controller: SLComposeViewController = SLComposeViewController(forServiceType: shareMethod)
        controller.setInitialText("Love you so much!")
        controller.addImage(bgImg.image)
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func twitterTapped(sender: AnyObject) {
        share(forServiceType: SLServiceTypeTwitter)
    }

    @IBAction func facebookTapped(sender: AnyObject) {
        share(forServiceType: SLServiceTypeFacebook)
    }
    
    @IBAction func sinaTapped(sender: AnyObject) {
        share(forServiceType: SLServiceTypeSinaWeibo)
    }
    
}

