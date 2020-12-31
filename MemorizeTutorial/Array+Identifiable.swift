//
//  Array+Identifiable.swift
//  MemorizeTutorial
//
//  Created by lum jian yang sean on 31/12/20.
//  Copyright © 2020 sean lum. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index // swift will automatically return an Optional<Int>
            }
        }
        return nil
    }
}
