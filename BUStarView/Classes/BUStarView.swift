//
//  BUStarView.swift
//  BUStarView
//
//  Created by Виктор on 17/12/2018.
//

import UIKit

@IBDesignable
public class BUStarView: UIView {
    
    @IBInspectable public var vertices: Int = 5 {
        didSet {
            if (vertices % 2 == 0) {
                vertices += 1
            }
            if (vertices > 9) {
                vertices = 9
            }
            setNeedsDisplay()
        }
    }
    @IBInspectable public var outerRadius: CGFloat = 1 {
        didSet {
            if (!(innerRadius..<1).contains(outerRadius)) {
                outerRadius = oldValue
            }
            setNeedsDisplay()
        }
    }
    @IBInspectable public var innerRadius: CGFloat = 0.5 {
        didSet {
            if (!(0.2..<outerRadius).contains(innerRadius)) {
                innerRadius = oldValue
            }
            setNeedsDisplay()
        }
    }
    @IBInspectable public var outerRound:  CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var innerRound:  CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var fill: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var borderColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var fillColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private enum Radius {
        case inner, outer
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.clear(rect)
        let radius = min(rect.width/2, rect.height/2)
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        let outerPoints = getStarPoints(count: vertices, center: center, radius: radius * outerRadius, type: .outer);
        let innerPoints = getStarPoints(count: vertices, center: center, radius: radius * innerRadius, type: .inner);
        connectPoints(innerPoints: innerPoints, outerPoints: outerPoints)
    }
    
    private func connectPoints(innerPoints: [CGPoint], outerPoints: [CGPoint]) {
        var allPoints = [CGPoint]()
        for (i, point) in outerPoints.enumerated() {
            var sorted = innerPoints.sorted(by: { (f, s) -> Bool in
                return distance(f, point) < distance(s, point)
            })
            if (i == 0) {
                let point = sorted[0].x > sorted[1].x ? sorted[0] : sorted[1]
                allPoints.append(point)
            }
            allPoints.append(point)
            if !allPoints.contains(sorted[1]) {
                allPoints.append(sorted[1])
            } else if !allPoints.contains(sorted[0]) {
                allPoints.append(sorted[0])
            }
        }
        
        let ctx = UIGraphicsGetCurrentContext()
        let middlePoint = CGPoint(x: 0.5 * (allPoints[0].x + allPoints.last!.x),
                                  y: 0.5 * (allPoints[0].y + allPoints.last!.y))
        ctx?.move(to: middlePoint)
        for i in 0..<allPoints.count {
            let firstPoint = allPoints[i]
            let secondPoint: CGPoint
            let radius = i % 2 == 0 ? innerRound : outerRound
            if i + 1 >= allPoints.count {
                secondPoint = allPoints[0]
            } else {
                secondPoint = allPoints[i + 1]
            }
            ctx?.addArc(tangent1End: firstPoint,
                        tangent2End: secondPoint,
                        radius: radius)
        }
        ctx?.addLine(to: middlePoint)
        if fill {
            fillColor.setFill()
            ctx?.fillPath()
        }
        borderColor.setStroke()
        ctx?.strokePath()
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    
    private func getStarPoints(count: Int, center: CGPoint, radius: CGFloat, type: Radius) -> [CGPoint] {
        let step = 360 / count
        var points = [CGPoint]()
        let multiplier: CGFloat = type == .inner ? -1 : 1;
        for i in 0..<count {
            let point = getPoint(piVal: toRad(val: CGFloat(step * i) + 90 * multiplier), center: center, radius: radius)
            points.append(point)
        }
        return points
    }
    
    private func getPoint(piVal: CGFloat, center: CGPoint, radius: CGFloat) -> CGPoint {
        var point = CGPoint()
        point.x = center.x + radius * cos(piVal)
        point.y = center.y - radius * sin(piVal)
        return point
    }
    
    private func toRad(val: CGFloat) -> CGFloat {
        return val * CGFloat.pi / 180
    }
}
