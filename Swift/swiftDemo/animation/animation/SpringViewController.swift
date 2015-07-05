//
//  SpringViewController.swift
//  animation
//
//  Created by Eular on 15/7/5.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class SpringViewController: UIViewController {

    @IBOutlet weak var redBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.redBox.center.y = self.view.bounds.height - self.redBox.center.y
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
