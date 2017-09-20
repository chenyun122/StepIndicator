//
//  AnnularLayer.swift
//  CYStepIndicator
//
//  Created by Yun CHEN on 2017/9/1.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

class AnnularLayer: CAShapeLayer {
    
    let fullCircleLayer = CAShapeLayer()
    let centerLayer = CAShapeLayer()
    let flagLayer = CALayer()
    let annularPath = UIBezierPath()

    static let originalScale = CATransform3DMakeScale(1.0, 1.0, 1.0)
    static let flagImageName = "CYStepIndicator_ic_done_white"
    static var flagCGImage:CGImage?
    
    override init() {
        super.init()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 3
        
        if AnnularLayer.flagCGImage == nil {
            var flagImage = UIImage(named: AnnularLayer.flagImageName)
            if flagImage == nil {
                let bundle = Bundle(for: AnnularLayer.self)
                if let url = bundle.url(forResource: "StepIndicator", withExtension: "bundle") {
                    let bundle = Bundle(url: url)
                    flagImage = UIImage(named: AnnularLayer.flagImageName, in: bundle, compatibleWith: nil)
                }
            }
            AnnularLayer.flagCGImage = flagImage?.cgImage
        }

        self.flagLayer.contents = AnnularLayer.flagCGImage
        self.fullCircleLayer.addSublayer(self.flagLayer)
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
    
    var isCurrent:Bool = false {
        didSet{
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
        if isFinished {
            self.path = nil
            self.drawFullCircleAnimated()
        }
        else{
            fullCircleLayer.removeFromSuperlayer()
            
            self.drawAnnularPath()
            
            if isCurrent {
                self.drawCenterAnimated()
            }
            else{
                centerLayer.removeFromSuperlayer()
            }
        }
    }
    
    private func drawAnnularPath() {
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0 - self.lineWidth / 2.0
        
        self.annularPath.removeAllPoints()
        self.annularPath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.path = self.annularPath.cgPath
    }
    
    private func drawCenterAnimated() {
        let centerPath = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0 - self.lineWidth - sideLength * 0.15
        
        centerPath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.centerLayer.path = centerPath.cgPath
        self.centerLayer.transform = AnnularLayer.originalScale
        self.centerLayer.frame = self.bounds
        self.centerLayer.anchorPoint = CGPoint(x:0.5,y:0.5)
        self.centerLayer.fillColor = self.tintColor?.cgColor
        self.addSublayer(self.centerLayer)
        
        self.animateCenter()
    }
    
    private func animateCenter() {
        self.centerLayer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            CATransaction.setCompletionBlock {
                self.centerLayer.transform = AnnularLayer.originalScale
                self.centerLayer.removeAllAnimations()
            }
            self.centerLayer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0)
            self.centerLayer.removeAllAnimations()
            self.centerLayer.add(self.createTransformAnimationWithScale(x: 1.0, y: 1.0), forKey: "CenterLayerAnimationScale1.0")
        }
        self.centerLayer.add(self.createTransformAnimationWithScale(x: 1.1, y: 1.1), forKey: "CenterLayerAnimationScale1.1")
        CATransaction.commit()
    }
    
    private func createTransformAnimationWithScale(x:CGFloat,y:CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation()
        animation.keyPath = "transform"
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.toValue = CATransform3DMakeScale(x, y, 1)
        return animation
    }
    
    private func drawFullCircleAnimated() {
        let fullCirclePath = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0
        
        fullCirclePath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.fullCircleLayer.path = fullCirclePath.cgPath
        self.fullCircleLayer.transform = AnnularLayer.originalScale
        self.fullCircleLayer.frame = self.bounds
        self.fullCircleLayer.fillColor = self.tintColor?.cgColor
        self.addSublayer(self.fullCircleLayer)
        
        let flagLayerWidth = self.fullCircleLayer.bounds.width * 0.8
        let flagLayerHeight = self.fullCircleLayer.bounds.height * 0.8
        self.flagLayer.frame = CGRect(x: self.fullCircleLayer.bounds.width * 0.2 / 2.0, y: self.fullCircleLayer.bounds.height * 0.2 / 2.0, width:flagLayerWidth, height:flagLayerHeight)
        
        self.animateFullCircle()
    }
    
    private func animateFullCircle() {
        self.fullCircleLayer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        self.fullCircleLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.fullCircleLayer.transform = AnnularLayer.originalScale
        }
        self.fullCircleLayer.add(self.createTransformAnimationWithScale(x: 1.0, y: 1.0), forKey: "FullCircleAnimationScale1.0")
        CATransaction.commit()
    }
    
}
