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
            if vertices < 3 {
                vertices = oldValue
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
            if (!(0.1..<outerRadius).contains(innerRadius)) {
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
    
    private var radius: CGFloat {
        return min(frame.size.width/2, frame.size.height/2)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        let points = getPoints(count: vertices, center: center)
        connectPoints(points: points)
    }
    
    private func connectPoints(points: [CGPoint]) {
        let ctx = UIGraphicsGetCurrentContext()
        let middlePoint = middle(point1: points[0], point2: points.last!)
        ctx?.move(to: middlePoint)
        ctx?.setLineWidth(1.0)
        for i in 0..<points.count {
            let firstPoint = points[i]
            let secondPoint: CGPoint
            let radius = i % 2 == 0 ? outerRound : innerRound
            if i + 1 >= points.count {
                secondPoint = points[0]
            } else {
                secondPoint = points[i + 1]
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
    
    private func getPoints(count: Int, center: CGPoint) -> [CGPoint] {
        let pi: CGFloat = CGFloat.pi
        let step: CGFloat = 2 * pi / CGFloat(count)
        var points = [CGPoint]()
        let outerOffset: CGFloat = pi / 2
        let innerOffset: CGFloat = outerOffset + pi / CGFloat(vertices)
        for i in 0..<count {
            let outerPoint = getPoint(piVal: step * CGFloat(i) + outerOffset,
                                      center: center, radius: radius * outerRadius)
            points.append(outerPoint)
            let innerPoint = getPoint(piVal: step * CGFloat(i) + innerOffset,
                                      center: center, radius: radius * innerRadius)
            points.append(innerPoint)
        }

//        let point1 = middle(point1: points[1], point2: points[3])
//        let distance = sqrt(pow(Double(point1.x) - Double(points[1].x), 2.0) + pow(Double(point1.y) - Double(points[1].y), 2))
//        print(distance)
//        let point1 = points[1]
//        let point2 = points[2]
//        let point3 = points[3]
//        let a = length(point1: point1, point2: point2)
//        let b = length(point1: point2, point2: point3)
//        let c = length(point1: point1, point2: point3)
//        let perimeter = (a + b + c) / 2.0
//        let r = sqrt((perimeter - a) * (perimeter - b) * (perimeter - c)/perimeter)
//        print(r)
//        let path = UIBezierPath()
//        path.move(to: point1)
//        path.addLine(to: point3)
//        path.stroke()
        
//        let point1 = middle(point1: points[0], point2: points[1])
//        let point2 = middle(point1: points[1], point2: points[2])
//
//
//        print(getRadius(piAngle: step / 2, hypotenuse: CGFloat(distance)))
//        let point3 = middle(point1: points[1], point2: points[2])
//        let point4 = middle(point1: points[2], point2: points[3])
//        let distance2 = sqrt(pow(Double(point3.x) - Double(point4.x), 2.0) + pow(Double(point3.y) - Double(point4.y), 2))
//        print(getRadius(piAngle: step / 2, hypotenuse: CGFloat(distance2)))

//        path.move(to: point3)
//        path.addLine(to: point4)
        return points
    }
    
    private func getRadius(piAngle: CGFloat, hypotenuse: CGFloat) -> CGFloat {
        return hypotenuse * tan(piAngle)
    }
    
    private func getPoint(piVal: CGFloat, center: CGPoint, radius: CGFloat) -> CGPoint {
        var point = CGPoint()
        point.x = center.x + radius * cos(piVal)
        point.y = center.y - radius * sin(piVal)
        return point
    }
    
    private func middle(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: 0.5 * (point1.x + point2.x),
                       y: 0.5 * (point1.y + point2.y))
    }
    
    private func length(point1: CGPoint, point2: CGPoint) -> Double {
        return sqrt(pow(Double(point1.x) - Double(point2.x), 2.0) + pow(Double(point1.y) - Double(point2.y), 2))
    }
}
