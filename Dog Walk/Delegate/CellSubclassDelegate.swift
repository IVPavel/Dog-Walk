//
//  CellSubclassDelegate.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/7/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

protocol CellSubclassDelegate: class {
    func buttonTapped(cell: CollectionViewCell)
}
