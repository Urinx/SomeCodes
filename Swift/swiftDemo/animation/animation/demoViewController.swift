//
//  demoViewController.swift
//  animation
//
//  Created by Eular on 15/7/5.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class demoViewController: UIViewController {

    var boxWidth:CGFloat = 50
    var d:Int = 4
    var padding:CGFloat = 20
    var backgrounds: Array<UIView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backgrounds = Array<UIView>()
        setupGameMap()
    }
    
    func setupGameMap() {
        let x:CGFloat = 30
        let y:CGFloat = 150
        
        for i in 0..<d {
            let dx:CGFloat = (boxWidth+padding)*CGFloat(i)
            for j in 0..<d {
                let dy:CGFloat = (boxWidth+padding)*CGFloat(j)
                let box = UIView(frame: CGRectMake(x+dx, y+dy, boxWidth, boxWidth))
                box.backgroundColor = UIColor.grayColor()
                self.view.addSubview(box)
                backgrounds.append(box)
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        playAnimation()
    }
    
    func playAnimation() {
        UIView.animateWithDuration(1, delay: 0, options: [.Repeat, .Autoreverse], animations: {
            for box in self.backgrounds {
                box.transform = CGAffineTransformScale(box.transform, 0.5, 0.5)
                box.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }
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
