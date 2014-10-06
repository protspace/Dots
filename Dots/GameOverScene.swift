//
//  GameOverScene.swift
//  Dots
//
//  Created by Sagidulin on 06.10.14.
//  Copyright (c) 2014 Protspace Corp. All rights reserved.
//

//
//  GameOverScene.swift
//  SpriteKitSimpleGame
//
//  Created by Sagidulin on 04.10.14.
//  Copyright (c) 2014 Protspace Corp. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        var message = "Game over"
        
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = message
        label.fontSize = 20
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        runAction(SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.runBlock() {
                // 5
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}