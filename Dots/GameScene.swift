//
//  GameScene.swift
//  Dots
//
//  Created by Sagidulin on 04.10.14.
//  Copyright (c) 2014 Protspace Corp. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //Setting up field parameters constats
    let _gridSize: CGFloat = 25
    let _numRows: CGFloat = 10
    let _numCols: CGFloat = 15
    
    //Setting up Dots id constats
    let _redDotIdentifier = 255
    let _blueDotIdentifier = 254

    //An array of Dots
    var array = Matrix(rows:10,columns: 15)
    //Triggers players turns
    var playerTrigger: Bool = true
    

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()

        //Background
        self.scene?.scaleMode = SKSceneScaleMode.AspectFit
        let background = SKSpriteNode(imageNamed: "Grid")
        background.position = CGPointMake(CGRectGetMinX(self.frame),CGRectGetMinY(self.frame))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.size = self.size
        self.addChild(background)
        
        //Sprite for Blue Dot (label on the right, shows which turn is now)
        let spriteLabelDotBlue = SKSpriteNode(imageNamed:"DotBlue.png")
        spriteLabelDotBlue.name = "labelBlue"
        spriteLabelDotBlue.position = CGPoint(x: 420, y: 275)
        
        //Sprite for Red Dot (label on the right, shows which turn is now)
        let spriteLabelDotRed = SKSpriteNode(imageNamed:"DotRed.png")
        spriteLabelDotRed.name = "labelRed"
        spriteLabelDotRed.position = CGPoint(x: 450, y: 275)

        
        
        
        
        //Adding both Dot (Label) nodes
        self.addChild(spriteLabelDotBlue)
        self.addChild(spriteLabelDotRed)
        
        //Setting up turn-arrow (who's turn is now) with default
        self.postTurnLabel(255)

    }

    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        //Sprite for Blue Dot on the field
        let spriteDotBlue = SKSpriteNode(imageNamed:"DotBlue.png")
        spriteDotBlue.name = "blue"
        
        //Sprite for Red Dot on the field
        let spriteDotRed = SKSpriteNode(imageNamed:"DotRed.png")
        spriteDotRed.name = "red"
        
        
        //enumerating touch
        for touch: AnyObject in touches {
            
            //Determing location of touch point
            let location = touch.locationInNode(self)
            
            //If touch point position if NOT out of grid..
            if (snapDotPosition (location)? != nil) {
                
                //If the trigger is TRUE - its Reds' turn
                if playerTrigger {
                    
                    //setting Red's position (force unwrapped)
                    spriteDotRed.position = snapDotPosition (location)!
                    
                    //checking if it is free. If it is - marking it as occupied  with Reds
                    if array [Int((spriteDotRed.position.y-45)/_gridSize)-1,Int(spriteDotRed.position.x/_gridSize)-1] == 0 {
                        array [Int((spriteDotRed.position.y-45)/_gridSize)-1,Int(spriteDotRed.position.x/_gridSize)-1] = _redDotIdentifier
                        
                        //Adding the Red node
                        self.addChild(spriteDotRed)
                        //changing the label. Now it is Blue's turn
                        self.postTurnLabel (_blueDotIdentifier)

                    //if busy
                    } else {
                        println ("item in array is busy")
                        return
                    }
                
                
                }   else  {
                
                    //setting Blue's position (force unwrapped)
                    spriteDotBlue.position = snapDotPosition (location)!
                    
                    //checking if it is free. If it is - marking it as occupied  with Blue's
                    if array [Int((spriteDotBlue.position.y-45)/_gridSize)-1,Int(spriteDotBlue.position.x/_gridSize)-1] == 0 {
                        array [Int((spriteDotBlue.position.y-45)/_gridSize)-1,Int(spriteDotBlue.position.x/_gridSize)-1] = _blueDotIdentifier
                        
                        //Adding the Blue node
                        self.addChild(spriteDotBlue)
                        //changing the label. Now it is Red's turn
                        self.postTurnLabel(_redDotIdentifier)
                        
                    //if busy
                    } else {
                        println ("item in array is busy")
                        return
                    }

                    }
               //changing turn trugger
                playerTrigger = !playerTrigger
            }
            
        }
    }
   
    
    
    //Moving arrows that shows which turn it is now
    func postTurnLabel (player: Int) {
        
        let spriteArrowReds = SKSpriteNode(imageNamed:"ArrowDown.png")
        spriteArrowReds.name = "arrowReds"
        spriteArrowReds.position = CGPoint(x: 450, y: 295)

        
        let spriteArrowBlues = SKSpriteNode(imageNamed:"ArrowDown.png")
        spriteArrowBlues.name = "arrowBlues"
        spriteArrowBlues.position = CGPoint(x: 420, y: 295)

        
        if player == _redDotIdentifier {
            self.childNodeWithName("arrowBlues")?.removeFromParent()
            addChild(spriteArrowReds)

            }
        else {
            self.childNodeWithName("arrowReds")?.removeFromParent()
            addChild(spriteArrowBlues)


        }
  
        
    }
    
 
    //Changing postition of Dot so it will now snap the field grid  
    func snapDotPosition (oldPosition: CGPoint) -> CGPoint? {
        
        if (((oldPosition.y <= 45))||((oldPosition.x >= 400))) {
            println("error touching")
            return nil
        }
    
        var newPosition = CGPoint(x: 0,y: 0)
        
        
        
        if (oldPosition.x < _gridSize) {
            newPosition.x = _gridSize
           
            
        } else {
        
            if (oldPosition.x > _gridSize*_numCols) {
                newPosition.x = _gridSize*_numCols
            } else {
                
                if (oldPosition.x % _gridSize) == 0 {
                    newPosition.x = oldPosition.x
                } else {
            
        
                    if ( ((oldPosition.x % _gridSize) < (_gridSize/2)) &&  ((oldPosition.x % _gridSize) > 0) ) {
        
                        newPosition.x = CGFloat (((Int (oldPosition.x))/Int(_gridSize)) * Int(_gridSize) )
                    }
                    else {
            
                        newPosition.x = CGFloat (((Int (oldPosition.x))/Int(_gridSize))*Int(_gridSize) + Int(_gridSize))
                    }
        
                }
             }
           }
        
        
        if (oldPosition.y > (CGRectGetMaxY(self.frame) - _gridSize)) {
            newPosition.y = (CGRectGetMaxY(self.frame) - _gridSize)
        } else {
            
            if (oldPosition.y<70) {
                newPosition.y = 70
            }
            else {
                if (oldPosition.y % _gridSize) == 0 {
                    newPosition.y = oldPosition.y
                } else {

                    if ( ((oldPosition.y % _gridSize ) < (_gridSize/2)) &&  ((oldPosition.y % _gridSize) > 0) ) {
            
                        newPosition.y = CGFloat (((Int (oldPosition.y))/Int(_gridSize))*Int(_gridSize)-5)
                    } else {
            
                        newPosition.y = CGFloat (((Int (oldPosition.y))/Int(_gridSize))*Int(_gridSize) + Int(_gridSize) - 5.0)
                    }
                }
            }
        }
        
    
    //returning new snapped to grid position of the Dot
    return newPosition
        
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
