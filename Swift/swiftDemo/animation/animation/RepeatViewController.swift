//
//  RepeatViewController.swift
//  animation
//
//  Created by Eular on 15/7/5.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController {

    @IBOutlet weak var redBox: UIView!
    @IBOutlet weak var blueBox: UIView!
    @IBOutlet weak var greenBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, animations: {
            self.redBox.center.x = self.view.bounds.width - self.redBox.center.x
        })
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.Repeat, animations: {
            self.blueBox.center.x = self.view.bounds.width - self.blueBox.center.x
        }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 0, options: [.Repeat, .Autoreverse], animations: {
            self.greenBox.center.x = self.view.bounds.width - self.greenBox.center.x
            }, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
