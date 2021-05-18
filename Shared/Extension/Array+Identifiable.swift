//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Pao Yu on 2021-04-23.
//

import Foundation

extension Array where Element: Identifiable {
    public func firstIndex(matching: Element) -> Int? {
        for index in 0 ..< self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
