//
//  AnnularLayer.swift
//  StepIndicator
//
//  Created by Yun CHEN on 2017/9/1.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

class AnnularLayer: CAShapeLayer {
    
    private let fullCircleLayer = CAShapeLayer()
    private let centerCircleLayer = CAShapeLayer()
    private let flagLayer = CALayer()
    private let annularPath = UIBezierPath()
    lazy private var centerTextLayer = CATextLayer()
    
    static private let originalScale = CATransform3DMakeScale(1.0, 1.0, 1.0)
    static private let flagImageName = "CYStepIndicator_ic_done_white"
    static private var flagCGImage:CGImage?
    
    
    // MARK: - Properties
    var tintColor:UIColor?
    var displayNumber = false
    var step:Int = 0
    var annularDefaultColor: UIColor?
    
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
    
    
    //MARK: - Initialization
    override init() {
        super.init()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 3
        
        if AnnularLayer.flagCGImage == nil {
            var flagImage = UIImage(named: AnnularLayer.flagImageName)
            
            //For Pods bundle
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

    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // MARK: - Functions
    func updateStatus() {
        if isFinished {
            self.path = nil
            self.drawFullCircleAnimated()
        }
        else{
            fullCircleLayer.removeFromSuperlayer()
            
            self.drawAnnularPath()

            if self.displayNumber {
                self.centerCircleLayer.removeFromSuperlayer()
                
                if isCurrent {
                    self.strokeColor = self.tintColor?.cgColor
                }
                else{
                    self.strokeColor = self.annularDefaultColor?.cgColor
                }
                
                self.drawText()
            }
            else{
                self.centerTextLayer.removeFromSuperlayer()
                self.strokeColor = self.annularDefaultColor?.cgColor
                
                if isCurrent {
                    self.drawCenterCircleAnimated()
                }
                else{
                    self.centerCircleLayer.removeFromSuperlayer()
                }
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
    
    private func drawCenterCircleAnimated() {
        let centerPath = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0 - self.lineWidth - sideLength * 0.15
        
        centerPath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.centerCircleLayer.path = centerPath.cgPath
        self.centerCircleLayer.transform = AnnularLayer.originalScale
        self.centerCircleLayer.frame = self.bounds
        self.centerCircleLayer.anchorPoint = CGPoint(x:0.5,y:0.5)
        self.centerCircleLayer.fillColor = self.tintColor?.cgColor
        self.addSublayer(self.centerCircleLayer)
        
        self.centerTextLayer.removeFromSuperlayer()
        
        self.animateCenter()
        self.strokeColor = self.annularDefaultColor?.cgColor
    }
    
    private func drawText() {
        let sideLength = fmin(self.frame.width, self.frame.height)
        
        self.centerTextLayer.string = "\(self.step)"
        self.centerTextLayer.frame = self.bounds
        self.centerTextLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY * 1.2)
        self.centerTextLayer.contentsScale = UIScreen.main.scale
        self.centerTextLayer.foregroundColor = self.strokeColor
        self.centerTextLayer.alignmentMode = CATextLayerAlignmentMode.center
        let fontSize = sideLength * 0.65
        self.centerTextLayer.font = UIFont.boldSystemFont(ofSize: fontSize) as CFTypeRef
        self.centerTextLayer.fontSize = fontSize
        
        self.addSublayer(self.centerTextLayer)
    }
    
    private func animateCenter() {
        self.centerCircleLayer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            CATransaction.setCompletionBlock {
                self.centerCircleLayer.transform = AnnularLayer.originalScale
                self.centerCircleLayer.removeAllAnimations()
            }
            self.centerCircleLayer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0)
            self.centerCircleLayer.removeAllAnimations()
            self.centerCircleLayer.add(self.createTransformAnimationWithScale(x: 1.0, y: 1.0), forKey: "CenterLayerAnimationScale1.0")
        }
        self.centerCircleLayer.add(self.createTransformAnimationWithScale(x: 1.1, y: 1.1), forKey: "CenterLayerAnimationScale1.1")
        CATransaction.commit()
    }
    
    private func createTransformAnimationWithScale(x:CGFloat,y:CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation()
        animation.keyPath = "transform"
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
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
