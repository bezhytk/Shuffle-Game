//
//  Array2D.swift
//  spk-6
//
//  Created by cpe01 on 10/20/2559 BE.
//  Copyright © 2559 cpe01. All rights reserved.
//

//import Foundation
struct Array2D<T> {
    let columns: Int
    let rows: Int
    private var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count: rows*columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}