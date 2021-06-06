//
//  Array+LoneItem.swift
//  Memorize
//
//  Created by Pao Yu on 2021-06-05.
//

import Foundation

extension Array {
    var loneItem: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
