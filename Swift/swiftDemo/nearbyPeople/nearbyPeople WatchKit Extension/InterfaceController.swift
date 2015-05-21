//
//  InterfaceController.swift
//  nearbyPeople WatchKit Extension
//
//  Created by Eular on 15/5/21.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var peopleImg: WKInterfaceImage!
    @IBOutlet weak var infoLable: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    @IBAction func searchNearbyPeople() {
        peopleImg.setImageNamed("p")
        peopleImg.startAnimatingWithImagesInRange(NSRange(location: 0, length: 5), duration: 0.3, repeatCount: 3)
        
        delay(0.9){
            var num = arc4random_uniform(5)
            self.peopleImg.setImageNamed("p\(num)")
            switch num {
            case 0:
                self.infoLable.setText("帅气男神")
            case 1:
                self.infoLable.setText("猥琐大叔")
            case 2:
                self.infoLable.setText("清纯小妹")
            case 3:
                self.infoLable.setText("邻家大婶")
            case 4:
                self.infoLable.setText("蕾丝还是Guy?")
            default:
                self.infoLable.setText(" ")
            }
        }
        
    }
}
