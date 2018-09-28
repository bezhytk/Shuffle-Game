//
//  AnimalKid.swift
//  spk-6
//
//  Created by cpe01 on 10/20/2559 BE.
//  Copyright © 2559 cpe01. All rights reserved.
//

//import Foundation
import SpriteKit

enum AnimalType: Int, CustomStringConvertible {
    case unknown = 0, panda, babe, fox, raccoon, lion, bear
    var spriteName: String {
        let spriteNames = [
            "panda",
            "babe",
            "fox",
            "raccoon",
            "lion",
            "bear"]
        
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    static func random() -> AnimalType {
        return AnimalType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
    var description: String {
        return spriteName
    }
    
    
}
func ==(lhs: AnimalKid, rhs: AnimalKid) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}
//class AnimalKid {
class AnimalKid:CustomStringConvertible, Hashable {
var column: Int
    var row: Int
    let animalType: AnimalType
    var sprite: SKSpriteNode? //Optional
    
    init(column: Int, row: Int, animalType: AnimalType) {
        self.column = column
        self.row = row
        self.animalType = animalType
    }
    var description: String {
        return "type:\(animalType) square:(\(column),\(row))"
    }
    var hashValue: Int {
        return row*10 + column
    }
}