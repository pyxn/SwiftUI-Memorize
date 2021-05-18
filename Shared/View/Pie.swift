//
//  Pie.swift
//  Memorize
//
//  Created by Pao Yu on 2021-04-24.
//

import SwiftUI

struct Pie: Shape {
    
    public var startAngle: Angle
    public var endAngle: Angle
    public var isClockwise: Bool = false
    
    var animatableData: AnimatablePair<Double, Double> {
        // Double: angles in radians
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    public func path(in rect: CGRect) -> Path {
        
        let radius:     CGFloat = min(rect.width, rect.height) / 2
        
        let center:     CGPoint = CGPoint(x: rect.midX, y: rect.midY)
        let start:      CGPoint = CGPoint(
                                    x: center.x + radius * cos(CGFloat(startAngle.radians)),
                                    y: center.y + radius * sin(CGFloat(startAngle.radians)))
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center:     center,
            radius:     radius,
            startAngle: startAngle,
            endAngle:   endAngle,
            clockwise:  isClockwise)
        p.addLine(to: center)
        
        return p
    }
}
