//
//  ViewController.swift
//  picTransform
//
//  Created by Eular on 15/4/18.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    
    private var hasTransited: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(img1)
        self.view.multipleTouchEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if touches.count == 1 {
            if hasTransited {
                UIView.transitionFromView(img2, toView: img1, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: transitionComplete)
            } else {
                UIView.transitionFromView(img1, toView: img2, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: transitionComplete)
            }
        } else {
            if hasTransited {
                UIView.transitionWithView(img2, duration: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: anim2, completion: nil)
            } else {
                UIView.transitionWithView(img1, duration: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: anim1, completion: nil)
            }
        }
    }
    
    func transitionComplete(b: Bool) {
        println("Flip the picture")
        hasTransited = !hasTransited
    }
    
    func anim1() {
        img1.alpha = 0.5
        img1.center = CGPoint(x: 200, y: 300)
    }
    
    func anim2() {
        img2.alpha = 0.5
        img2.center = CGPoint(x: 50, y: 200)
    }

}

