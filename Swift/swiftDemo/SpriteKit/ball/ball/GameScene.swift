//
//  GameScene.swift
//  ball
//
//  Created by Eular on 15/4/23.
//  Copyright (c) 2015年 Eular. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameStarted: Bool = false
    var baseman: SKSpriteNode!
    let MASK_EDGE: UInt32 = 0b1
    let MASK_BALL: UInt32 = 0b10
    let MASK_BASEMAN: UInt32 = 0b100
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        // 碰撞检测
        self.physicsBody?.contactTestBitMask = MASK_EDGE
        self.physicsWorld.contactDelegate = self
        
        baseman = childNodeWithName("baseman") as! SKSpriteNode
    }
    
    // 碰撞检测
    func didBeginContact(contact: SKPhysicsContact) {
        let maskCode = contact.bodyA.contactTestBitMask | contact.bodyB.contactTestBitMask
        switch maskCode {
        case MASK_EDGE | MASK_BALL:
            if contact.bodyA.contactTestBitMask == MASK_BALL {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
        case MASK_EDGE | MASK_BASEMAN:
            self.view?.presentScene(GameOverScene(size: self.frame.size))
        default:
            return
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if gameStarted {
            // 添加棒球
            for touch in (touches as! Set<UITouch>) {
                let location = touch.locationInNode(self)
                var ball = SKSpriteNode(imageNamed: "baseball11")
                ball.xScale = 0.1
                ball.yScale = 0.1
                ball.position = location
                ball.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "baseball11"), size: ball.frame.size)
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 800)
                ball.physicsBody?.contactTestBitMask = MASK_BALL
                self.addChild(ball)
            }
        } else {
            gameStarted = true
            
            // 隐藏提示文字
            let tapLabel = childNodeWithName("tapLabel")
            tapLabel?.hidden = true
            
            // 设置 baseman 的物理属性
            baseman.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "baseballman"), size: baseman.frame.size)
            baseman.physicsBody?.restitution = 0.6
            baseman.physicsBody?.contactTestBitMask = MASK_BASEMAN
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
