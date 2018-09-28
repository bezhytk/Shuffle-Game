//
//  GameScene.swift
//  spk-7
//
//  Created by cpe01 on 10/23/2559 BE.
//  Copyright (c) 2559 cpe01. All rights reserved.
//


import SpriteKit

class GameScene: SKScene {
    var level: Level!
    let tilesLayer = SKNode()
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
    let gameLayer = SKNode()
    let animalKidsLayer = SKNode()
    var swipeFromColumn: Int?
    var swipeFromRow: Int?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = SKColor.init(colorLiteralRed: 0.3, green: 0.4, blue: 0.4, alpha: 1.0)
        let background = SKSpriteNode(imageNamed:
            "backGround3")
        background.size = size
        addChild(background)
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        
        animalKidsLayer.position = layerPosition
        gameLayer.addChild(animalKidsLayer)
        swipeFromColumn = nil
        swipeFromRow = nil
    }
    
    func addSprites(for animalKids: Set<AnimalKid>) {
        for animalKid in animalKids {
            let sprite = SKSpriteNode(imageNamed:animalKid.animalType.spriteName)
            sprite.size = CGSize(width: 2*TileWidth/3, height: 2*TileHeight/3)
            sprite.position = pointFor(
                animalKid.column, row: animalKid.row)
            animalKidsLayer.addChild(sprite)
            animalKid.sprite = sprite
        }
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }

    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
            return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        // Convert the touch location to a point relative to the cookiesLayer.
        let location = touch.locationInNode(animalKidsLayer)
        
        // If the touch is inside a square, then this might be the start of a
        // swipe motion.
        let (success, column, row) = convertPoint(location)
        if success {
            // The touch must be on a cookie, not on an empty tile.
            if let animalKid = level.animalKidAt(column, row: row) {
                // Remember in which column and row the swipe started, so we can compare
                // them later to find the direction of the swipe. This is also the first
                // cookie that will be swapped.
                swipeFromColumn = column
                swipeFromRow = row
                //showSelectionIndicatorForCookie(cookie)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?){
    // 1
        guard swipeFromColumn != nil else { return }
        
        // 2
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(animalKidsLayer)
        
        let (success, column, row) = convertPoint(location)
        if success {
            
            // 3
            var horzDelta = 0, vertDelta = 0
            if column < swipeFromColumn! {          // swipe left
                horzDelta = -1
            } else if column > swipeFromColumn! {   // swipe right
                horzDelta = 1
            } else if row < swipeFromRow! {         // swipe down
                vertDelta = -1
            } else if row > swipeFromRow! {         // swipe up
                vertDelta = 1
            }
            
            // 4
            if horzDelta != 0 || vertDelta != 0 {
                trySwap(horizontal: horzDelta, vertical: vertDelta)
                
                // 5
                swipeFromColumn = nil
            }
        }
    }
    func trySwap(horizontal horzDelta: Int, vertical vertDelta: Int) {
        // 1
print("---------- 1 -----------")
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        // 2
        guard toColumn >= 0 && toColumn < NumColumns else { return }
        guard toRow >= 0 && toRow < NumRows else { return }
            if let toAnimalKid = level.animalKidAt(toColumn, row: toRow),
                let fromAnimalKid = level.animalKidAt(swipeFromColumn!, row: swipeFromRow!){
            
            // 4
            print("-- Moving \(fromAnimalKid) to \(toAnimalKid)")
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent: UIEvent?) {
        print("---------- 13 -----------")
        swipeFromColumn = nil
        swipeFromRow = nil
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let touches = touches {
            touchesEnded(touches, withEvent: event)
        }
    }

    
    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                print(level.tileAt(column, row: row))
                if level.tileAt(column, row: row) != nil {print("a2")
                    let tileNode = SKSpriteNode(imageNamed: "Tile")
                    tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                    tileNode.position = pointFor(column, row: row)
                    tilesLayer.addChild(tileNode)
                }
            }
        }
    }
}
