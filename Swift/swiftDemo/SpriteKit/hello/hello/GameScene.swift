//
//  GameScene.swift
//  hello
//
//  Created by Eular on 15/4/23.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let tapLabel = childNodeWithName("tapLabel")
        tapLabel?.hidden = true
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let myLabel = SKLabelNode(text: "Hello world")
            myLabel.position = location
            myLabel.fontSize = 30
            myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
            myLabel.physicsBody!.restitution = 0.6
            self.addChild(myLabel)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
