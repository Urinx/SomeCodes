//
//  PositionViewController.swift
//  animation
//
//  Created by Eular on 15/7/5.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController {

    @IBOutlet weak var greenBox: UIView!
    @IBOutlet weak var blueBox: UIView!
    @IBOutlet weak var pinkBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1, animations: {
            self.pinkBox.center.x = self.view.bounds.width - self.pinkBox.center.x
        })
        
        UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.blueBox.center.y = self.view.bounds.height - self.blueBox.center.y
        }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.greenBox.center.x = self.view.bounds.width - self.greenBox.center.x
            self.greenBox.center.y = self.view.bounds.height - self.greenBox.center.y
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
