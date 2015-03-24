//
//  ViewController.swift
//  demo.3
//
//  Created by Eular on 15-3-24.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var girlPicker: UIPickerView
    let girls = ["吉泽明步","武藤兰","苍井空","泷泽萝拉","波多野结衣"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        girlPicker.dataSource = self
        girlPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "GotoGirlsView" {
            let i = girlPicker.selectedRowInComponent(0)
            let des = segue.destinationViewController as GirlsViewController
            des.index = i
        }
    }
    
    @IBAction func Close(segue: UIStoryboardSegue) {
        // ...
    }
}

