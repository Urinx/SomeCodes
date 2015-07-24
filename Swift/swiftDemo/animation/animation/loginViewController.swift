//
//  loginViewController.swift
//  animation
//
//  Created by Eular on 15/7/24.
//  Copyright © 2015年 Eular. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    @IBOutlet weak var bubble1: UIImageView!
    @IBOutlet weak var bubble2: UIImageView!
    @IBOutlet weak var bubble3: UIImageView!
    @IBOutlet weak var bubble4: UIImageView!
    @IBOutlet weak var bubble5: UIImageView!
    @IBOutlet weak var titleText: UIImageView!
    @IBOutlet weak var dot: UIImageView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    let warningMessage = UIImageView(image: UIImage(named: "Warning"))
    var loginBtnPosition = CGPoint.zeroPoint

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bubble1.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble2.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble3.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble4.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble5.transform = CGAffineTransformMakeScale(0, 0)
        
        let paddingViewForUser = UIView(frame: CGRectMake(0, 0, 40, self.user.frame.height))
        self.user.leftView = paddingViewForUser
        self.user.leftViewMode = .Always
        
        let userImageView = UIImageView(image: UIImage(named: "User"))
        userImageView.frame.origin = CGPoint(x: 13, y: 8)
        self.user.addSubview(userImageView)
        
        let paddingViewForPassword = UIView(frame: CGRectMake(0, 0, 40, self.password.frame.height))
        self.password.leftView = paddingViewForPassword
        self.password.leftViewMode = .Always
        
        let keyImageView = UIImageView(image: UIImage(named: "Key"))
        keyImageView.frame.origin = CGPoint(x: 12, y: 8)
        self.password.addSubview(keyImageView)
        
        self.loginBtnPosition = self.loginBtn.center
        self.view.addSubview(self.warningMessage)
        self.warningMessage.hidden = true
        self.warningMessage.frame.size = CGSizeMake(237, 40)
        self.warningMessage.center = self.loginBtnPosition
        
        self.dot.center.x -= self.view.bounds.width/2
        self.titleText.center.x -= self.view.bounds.width
        self.user.center.x -= self.view.bounds.width
        self.password.center.x -= self.view.bounds.width
        self.loginBtn.center.x -= self.view.bounds.width

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.bubble1.transform = CGAffineTransformMakeScale(1, 1)
            self.bubble5.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.bubble2.transform = CGAffineTransformMakeScale(1, 1)
            self.bubble4.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.bubble3.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.titleText.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animateWithDuration(5, delay: 1, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.dot.center.x += self.view.bounds.width/2
        }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.user.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.7, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.loginBtn.center.x += self.view.bounds.width
        }, completion: nil)

    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        self.loginBtn.addSubview(self.spinner)
        self.spinner.frame.origin = CGPointMake(15, 1)
        self.spinner.startAnimating()
        
        UIView.transitionWithView(self.warningMessage,
            duration: 0.3,
            options: .TransitionFlipFromTop,
            animations: {
                self.warningMessage.hidden = true
            }, completion: nil)
        
        UIView.animateWithDuration(0.3, animations: {
            self.loginBtn.center = self.loginBtnPosition
            }, completion: { _ in
            self.loginBtn.center.x -= 30
            UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginBtn.center.x += 30
                }, completion: {
                    _ in
                    UIView.animateWithDuration(0.3, animations: {
                        self.loginBtn.center.y += 60
                        self.spinner.removeFromSuperview()
                        }, completion: { _ in
                            UIView.transitionWithView(self.warningMessage, duration: 0.3, options: [.TransitionFlipFromTop, .CurveEaseOut], animations: {
                                _ in
                                self.warningMessage.hidden = false
                            },completion: nil)
                    })
            })
                

//            UIView.transitionWithView(self.warningMessage,
//            duration: 0.3,
//            options: .TransitionFlipFromTop | .CurveEaseOut,
//            animations: {
//            self.warningMessage.hidden = false
            

        })
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
