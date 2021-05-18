//
//  Array+Only.swift
//  Memorize
//
//  Created by Pao Yu on 2021-04-24.
//

import Foundation

extension Array {
    public var firstOfOneElementArray: Element? {
        count == 1 ? first : nil
    }
}
