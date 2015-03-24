//
//  GirlsViewController.swift
//  demo.3
//
//  Created by Eular on 15-3-24.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class GirlsViewController: UIViewController {
    
    var index: Int?
    
    @IBOutlet var bgImg: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if index != nil {
            bgImg.image = UIImage(named: String(index!))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // ...
    }
}
