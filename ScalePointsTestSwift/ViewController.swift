//
//  ViewController.swift
//  ScalePointsTestSwift
//
//  Created by Alexander Kormanovsky on 15.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var drawingView: DrawingView!
    @IBOutlet var originalButton: UIButton!
    @IBOutlet var scaledButton: UIButton!
    
    let pointsString = "(1265,1053),(1270,1051),(1273,1048),(1276,1041),(1280,1042),(1283,1039),(1286,1042),(1297,1033),(1298,1029),(1303,1031),(1308,1029),(1314,1027),(1319,1025),(1317,1032),(1314,1038),(1313,1047),(1312,1056),(1310,1062),(1311,1068),(1307,1071),(1311,1077),(1306,1074),(1301,1072),(1297,1072),(1289,1069),(1286,1071),(1277,1062),(1272,1057)"
    
    lazy var converter = CPPConverter(pointsString: pointsString)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let points = converter.originalPoints() as! [CGPoint]
        let boundingPoints = CPPConverter.boundingPoints(withPoints: points) as! [CGPoint]
        let pointsCenter = CPPConverter.pointsCenter(withPoints: boundingPoints)
        
        drawingView.update(withPoints: points, boundingPoints: boundingPoints, pointsCenter: pointsCenter)
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        
        let points = (sender == originalButton)
            ? converter.originalPoints() as! [CGPoint]
            : converter.scaledPoints(withScaleFactor: 1.5) as! [CGPoint]
        
        let boundingPoints = CPPConverter.boundingPoints(withPoints: points) as! [CGPoint]
        let pointsCenter = CPPConverter.pointsCenter(withPoints: points)
        
        drawingView.update(withPoints: points, boundingPoints: boundingPoints, pointsCenter: pointsCenter)
    }


}

