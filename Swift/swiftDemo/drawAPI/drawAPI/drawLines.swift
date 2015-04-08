//
//  drawLines.swift
//  drawAPI
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class drawLines: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        var context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, 100, 100)
        CGContextAddLineToPoint(context, 100, 200)
        CGContextAddLineToPoint(context, 200, 200)
        CGContextStrokePath(context)
        
        CGContextMoveToPoint(context, 100, 100)
        CGContextAddLineToPoint(context, 200, 100)
        CGContextAddLineToPoint(context, 200, 200)
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
        CGContextStrokePath(context)
    }


}
