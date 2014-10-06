//
//  GameViewController.swift
//  Dots
//
//  Created by Sagidulin on 04.10.14.
//  Copyright (c) 2014 Protspace Corp. All rights reserved.
//



import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    
     override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        // Configure the view.
        let skView = self.view as SKView
       // println(UIDevice.currentDevice().model)
            
            // Create and configure the scene.
            let scene = GameScene(size:skView.bounds.size)
            scene.scaleMode = .AspectFill;
            
            // Present the scene.
            skView.presentScene(scene)
        
        
        
    }

    
  
    
       
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
