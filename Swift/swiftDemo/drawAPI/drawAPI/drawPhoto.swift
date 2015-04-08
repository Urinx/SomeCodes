//
//  drawPhoto.swift
//  drawAPI
//
//  Created by Eular on 15/4/7.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import UIKit

class drawPhoto: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        // 因为CGContextDrawImage画出来的图像是颠倒的，所以先保存状态然后翻转画布再还原回来
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 0.0, self.bounds.size.height)
        CGContextScaleCTM(context, 1, -1)
        CGContextDrawImage(context, CGRect(x: 70, y: 180, width: 200, height: 200), UIImage(named: "wechat.jpg")?.CGImage)
        CGContextRestoreGState(context)
    }


}
