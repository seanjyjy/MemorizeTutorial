//
//  Array+Only.swift
//  MemorizeTutorial
//
//  Created by lum jian yang sean on 31/12/20.
//  Copyright © 2020 sean lum. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count ==  1 ? first : nil
    }
}
