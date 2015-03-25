//
//  GirlsViewController.swift
//  demo.3
//
//  Created by Eular on 15-3-24.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit
import Social

class GirlsViewController: UIViewController {
    
    var index: Int?
    
    @IBOutlet var bgImg: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if index != nil {
            bgImg.image = UIImage(named: String(index!))
            
            switch index! {
            case 0:
                navigationItem.title = "吉泽明步"
            case 1:
                navigationItem.title = "武藤兰"
            case 2:
                navigationItem.title = "苍井空"
            case 3:
                navigationItem.title = "泷泽萝拉"
            case 4:
                navigationItem.title = "波多野结衣"
            default:
                navigationItem.title = "Null"
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func shareTapped(sender: AnyObject) {
        var controller: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        controller.setInitialText("haha!")
        controller.addImage(bgImg.image)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}
