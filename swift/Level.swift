//
//  Level.swift
//  spk-6
//
//  Created by cpe01 on 10/20/2559 BE.
//  Copyright © 2559 cpe01. All rights reserved.
//

import Foundation
let NumColumns = 9
let NumRows = 9

class Level {
    //fileprivate var 
    private var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)
    init(filename: String) {
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename) else { return }
        // The dictionary contains an array named "tiles". This array contains
        // one element for each row of the level. Each of those row elements in
        // turn is also an array describing the columns in that row. If a column
        // is 1, it means there is a tile at that location, 0 means there is not.
        guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
        
        // Loop through the rows...
        for (row, rowArray) in tilesArray.enumerate() {
            // Note: In Sprite Kit (0,0) is at the bottom of the screen,
            // so we need to read this file upside down.
            let tileRow = NumRows - row - 1
            
            // Loop through the columns in the current r
            for (column, value) in rowArray.enumerate() {
                // If the value is 1, create a tile object.
                if value == 1 {
                    tiles[column, tileRow] = Tile()
                }
            }
        }
        
    }

    
    func tileAt(column: Int, row: Int) -> Tile? {print("tt\(tiles[column, row])")
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return tiles[column, row]
    }
    func animalKidAt(column: Int, row: Int) -> AnimalKid? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return animalKids[column, row]
    }
    private var animalKids = Array2D<AnimalKid>(columns: NumColumns, rows: NumRows)
    func shuffle() -> Set<AnimalKid> {
        return createInitialAnimals()
    }
    
    private func createInitialAnimals() -> Set<AnimalKid> {
        var set = Set<AnimalKid>()
        
        // 1
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
if tiles[column, row] != nil {
                let animalType = AnimalType.random()
                
                // 3
                let animalKid = AnimalKid(column: column, row: row, animalType: animalType)
                animalKids[column, row] = animalKid
                
                // 4
                set.insert(animalKid)
                }
            }
        }
        return set
    }
}