//
//  GameViewController.swift
//  spk-7
//
//  Created by cpe01 on 10/23/2559 BE.
//  Copyright (c) 2559 cpe01. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: GameScene!
    var level: Level!
     override func viewDidLoad() {
        super.viewDidLoad()
        level = Level(filename: "Level_1")
        // Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        skView.ignoresSiblingOrder = true
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present the scene.
        scene.level = level
        scene.addTiles()
        skView.presentScene(scene)
        beginGame()
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.Portrait,.PortraitUpsideDown]
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newAnimals = level.shuffle()
        scene.addSprites(for: newAnimals)
    }
}//end class GameViewController
