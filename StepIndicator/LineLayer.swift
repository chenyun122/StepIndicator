//
//  HorizontalLineLayer.swift
//  StepIndicator
//
//  Created by Yun CHEN on 2017/9/1.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

class LineLayer: CAShapeLayer {
    
    private let tintLineLayer = CAShapeLayer()
    
    // MARK: - Properties
    var tintColor:UIColor?
    var isFinished:Bool = false {
        didSet{
            self.updateStatus()
        }
    }
    
    var isHorizontal:Bool = true {
        didSet{
            self.updateStatus()
        }
    }
    
    //MARK: - Initialization
    override init() {
        super.init()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // MARK: - Functions
    func updateStatus() {
        self.drawLinePath()
        if isFinished {
            self.drawTintLineAnimated()
        }
        else{
            tintLineLayer.removeFromSuperlayer()
        }
    }
    
    private func drawLinePath() {
        let linePath = UIBezierPath()
        
        if self.isHorizontal {
            let centerY = self.frame.height / 2.0
            linePath.move(to: CGPoint(x: 0, y: centerY))
            linePath.addLine(to: CGPoint(x: self.frame.width, y: centerY))
        }
        else{
            let centerX = self.frame.width / 2.0
            linePath.move(to: CGPoint(x: centerX, y: 0))
            linePath.addLine(to: CGPoint(x:centerX , y: self.frame.height))
        }

        self.path = linePath.cgPath
    }
    
    private func drawTintLineAnimated() {
        let tintLinePath = UIBezierPath()
        
        if self.isHorizontal {
            let centerY = self.frame.height / 2.0
            tintLinePath.move(to: CGPoint(x: 0, y: centerY))
            tintLinePath.addLine(to: CGPoint(x: self.frame.width, y: centerY))
        }
        else{
            let centerX = self.frame.width / 2.0
            tintLinePath.move(to: CGPoint(x: centerX, y: 0))
            tintLinePath.addLine(to: CGPoint(x: centerX, y: self.frame.height))
        }

        self.tintLineLayer.path = tintLinePath.cgPath
        self.tintLineLayer.frame = self.bounds
        self.tintLineLayer.strokeColor = self.tintColor?.cgColor
        self.tintLineLayer.lineWidth = self.lineWidth
        
        self.addSublayer(self.tintLineLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        self.tintLineLayer.add(animation, forKey: "animationDrawLine")
    }
}
