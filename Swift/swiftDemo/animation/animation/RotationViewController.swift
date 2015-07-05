//
//  RotationViewController.swift
//  animation
//
//  Created by Eular on 15/7/5.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet weak var loading: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func spin() {
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.loading.transform = CGAffineTransformRotate(self.loading.transform, CGFloat(M_PI))
        }) { (finished) -> Void in
            self.spin()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.spin()
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
