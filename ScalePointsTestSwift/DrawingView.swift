//
//  DrawingView.swift
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

import UIKit

class DrawingView: UIView {
    
    private var points: [CGPoint]?
    private var boundingPoints: [CGPoint]?
    private var pointsCenter: CGPoint?


    override func draw(_ rect: CGRect) {
        let kPointSize: CGFloat = 3.0
        
        guard let points = points, !points.isEmpty,
              let boundingPoints = boundingPoints, !boundingPoints.isEmpty,
              let pointsCenter = pointsCenter else {
            return
        }

        // points

        UIColor.blue.setFill()

        for point in points {
            let path = UIBezierPath(ovalIn: CGRect(x: point.x - kPointSize / 2, y: point.y - kPointSize / 2, width: kPointSize, height: kPointSize))
            path.fill()
        }

        UIColor.magenta.setStroke()

        // bounding path

        let boundingPath = UIBezierPath()
        
        boundingPath.move(to: boundingPoints.first!)

        for i in 1..<boundingPoints.count {
            boundingPath.addLine(to: boundingPoints[i])
        }

        boundingPath.stroke()

        // center

        UIColor.red.setFill()

        let centerPath = UIBezierPath(ovalIn: CGRect(x: pointsCenter.x - kPointSize / 2, y: pointsCenter.y - kPointSize / 2, width: kPointSize, height: kPointSize))
        centerPath.fill()
    }
    
    func update(
        withPoints points: [CGPoint]?,
        boundingPoints: [CGPoint]?,
        pointsCenter: CGPoint
    ) {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1

        self.points = points
        self.boundingPoints = boundingPoints
        self.pointsCenter = pointsCenter

        setNeedsDisplay()
    }

}
