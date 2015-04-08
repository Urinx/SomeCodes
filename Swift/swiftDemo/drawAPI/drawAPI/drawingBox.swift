//
//  drawingBox.swift
//  drawAPI
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class drawingBox: UIView {
    
    var path = CGPathCreateMutable()
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var location = touches.anyObject()?.locationInView(self)
        CGPathMoveToPoint(path, nil, location!.x, location!.y)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var location = touches.anyObject()?.locationInView(self)
        CGPathAddLineToPoint(path, nil, location!.x, location!.y)
        setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, path)
        CGContextStrokePath(context)
    }


}
