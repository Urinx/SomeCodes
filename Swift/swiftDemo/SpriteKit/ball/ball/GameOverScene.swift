//
//  GameOverScene.swift
//  ball
//
//  Created by Eular on 15/4/23.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        var endLabel = SKLabelNode(text: "Game Over")
        endLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(endLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}