//
//  Swap.swift
//  spk-7
//
//  Created by cpe01 on 10/26/2559 BE.
//  Copyright © 2559 cpe01. All rights reserved.
//

struct Swap: CustomStringConvertible {
    let animalA: AnimalKid
    let animalB: AnimalKid
    
    init(animalA: AnimalKid, animalB: AnimalKid) {
        self.animalA = animalA
        self.animalB = animalB
    }
    
    var description: String {
        return "swap \(animalA) with \(animalB)"
    }
}