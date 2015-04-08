//
//  drawRect.swift
//  drawAPI
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class drawRect: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        CGContextAddRect(context, CGRect(x: 110, y: 210, width: 80, height: 80))
        CGContextFillPath(context)
        
        CGContextAddRect(context, CGRect(x: 100, y: 200, width: 100, height: 100))
        CGContextStrokePath(context)
    }


}
