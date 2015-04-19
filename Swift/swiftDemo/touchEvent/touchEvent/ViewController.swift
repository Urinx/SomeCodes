//
//  ViewController.swift
//  touchEvent
//
//  Created by Eular on 15/4/18.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    var lastDistence: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.multipleTouchEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // println("Touch Began")
        // var touch = touches.first as! UITouch
        // println(touch.locationInView(self.view))
        
        lastDistence = 0.0
    }

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // println("Touch Ended")
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        // println("Touch Moved")
        if touches.count == 2 {
            var x = [CGFloat](), y = [CGFloat]()
            for touch: AnyObject in touches {
                x += [touch.locationInView(self.view).x]
                y += [touch.locationInView(self.view).y]
            }
            var dx = x[0] - x[1]
            var dy = y[0] - y[1]
            var dist = sqrt(dx*dx + dy*dy)
            
            if lastDistence != 0.0 {
                if lastDistence - dist > 5 {
                    // println("缩小")
                    img.transform = CGAffineTransformScale(img.transform, 0.9, 0.9)
                } else if lastDistence - dist < -5 {
                    // println("放大")
                    img.transform = CGAffineTransformScale(img.transform, 1.1, 1.1)
                }
            }
            lastDistence = dist
        }
    }
}

