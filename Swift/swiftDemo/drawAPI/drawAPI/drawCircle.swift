//
//  drawCircle.swift
//  drawAPI
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class drawCircle: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        for r in 1...10 {
            CGContextAddArc(context, 160, 250, CGFloat(10*r), 0, 3.1415926*2, 0)
            CGContextMoveToPoint(context, CGFloat(160+10*r+10), 250)
        }
        
        CGContextStrokePath(context)
    }
    

}
