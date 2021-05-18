//
//  GridLayout.swift
//  Memorize
//
//  Calculates the dimension division for a Grid view using inputs:
//
//  @param itemCount   : Int
//  @param size        : CGSize
//

import SwiftUI

struct GridLayout {
    
    private(set) var size:           CGSize
    private(set) var rowCount:       Int     = 0
    private(set) var columnCount:    Int     = 0
    
    public var itemSize: CGSize  {
        if rowCount == 0 || columnCount == 0 {
            return CGSize.zero
        } else {
            return CGSize(
                width: size.width / CGFloat(columnCount),
                height: size.height / CGFloat(rowCount)
            )
        }
    }
    
    // Takes a number of items and its size, and divides it by those number of items
    public init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize) {
        
        self.size = size
        
        guard size.width != 0, size.height != 0, itemCount > 0 else {
            return
        }
        
        var bestLayout:         (rowCount: Int, columnCount: Int)   = (1, itemCount)
        var smallestVariance:   Double?
        let sizeAspectRatio:    Double                              = abs(Double(size.width/size.height))
        
        for rows in 1...itemCount {
            let columns: Int = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)
            if (rows - 1) * columns < itemCount {
                let itemAspectRatio = sizeAspectRatio * (Double(rows)/Double(columns))
                let variance = abs(itemAspectRatio - desiredAspectRatio)
                if smallestVariance == nil || variance < smallestVariance! {
                    smallestVariance = variance
                    bestLayout = (rowCount: rows, columnCount: columns)
                }
            }
        }
        rowCount = bestLayout.rowCount
        columnCount = bestLayout.columnCount
    }
    
    public func location(ofItemAt index: Int) -> CGPoint {
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.5) * itemSize.width,
                y: (CGFloat(index / columnCount) + 0.5) * itemSize.height
            )
        }
    }
}
