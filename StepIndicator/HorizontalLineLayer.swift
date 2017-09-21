//
//  HorizontalLineLayer.swift
//  StepIndicator
//
//  Created by Yun CHEN on 2017/9/1.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

class HorizontalLineLayer: CAShapeLayer {
    
    let tintLineLayer = CAShapeLayer()
    
    override init() {
        super.init()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Properties
    override var frame: CGRect {
        didSet{
            self.updateStatus()
        }
    }
    
    override var lineWidth: CGFloat {
        didSet{
            self.updateStatus()
        }
    }
    
    override var strokeColor: CGColor? {
        didSet {
            self.updateStatus()
        }
    }
    
    var tintColor:UIColor? {
        didSet {
            self.updateStatus()
        }
    }
    
    var isFinished:Bool = false {
        didSet{
            self.updateStatus()
        }
    }
    
    
    // MARK: - Functions
    private func updateStatus() {
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
        let centerY = self.frame.height / 2.0
        
        linePath.move(to: CGPoint(x: 0, y: centerY))
        linePath.addLine(to: CGPoint(x: self.frame.width, y: centerY))
        
        self.path = linePath.cgPath
    }
    
    private func drawTintLineAnimated() {
        let tintLinePath = UIBezierPath()
        let centerY = self.frame.height / 2.0
        
        tintLinePath.move(to: CGPoint(x: 0, y: centerY))
        tintLinePath.addLine(to: CGPoint(x: self.frame.width, y: centerY))
        
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
