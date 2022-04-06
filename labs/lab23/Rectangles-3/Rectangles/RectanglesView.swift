//
//  RectangleView.swift
//  Rectangles
//
//  Created by Kang, Hyungsuk on 3/31/22.
//

import UIKit

class RectanglesView: UIView {
    var points = [CGPoint]()
    
    var myDrawingColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsDisplay()
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        for pt in points {
            path.lineWidth = 3
            
            let drawingBounds = self.bounds
            var circleCenter = CGPoint()
            circleCenter.x = drawingBounds.origin.x + drawingBounds.size.width/2.0
            circleCenter.y = drawingBounds.origin.y + drawingBounds.size.height/2.0
            let theMinOfTheTwoSizes: CGFloat
            if (drawingBounds.size.width > drawingBounds.size.height) {
                theMinOfTheTwoSizes = drawingBounds.size.height
            } else {
                theMinOfTheTwoSizes = drawingBounds.size.width
            }
            path.move(to: CGPoint(x: pt.x + (theMinOfTheTwoSizes - path.lineWidth)/2, y: pt.y))
            for i in stride (from: 0, to: (theMinOfTheTwoSizes - path.lineWidth)/2, by: 20) {
                
                
                path.addArc(withCenter: pt, radius: (theMinOfTheTwoSizes - path.lineWidth)/2 - i, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
                
                path.move(to: CGPoint(x: pt.x + (theMinOfTheTwoSizes - path.lineWidth)/2 - (i + 20), y: pt.y))
                
            }
        }
        
        self.myDrawingColor.setStroke()
        path.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pt = t.location(in: self)
            points.append(pt)
            
        }
            
    
        
        self.setNeedsDisplay()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
