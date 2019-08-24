//
//  StepIndicatorView.swift
//  StepIndicator
//
//  Created by Yun Chen on 2017/7/14.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit


public enum StepIndicatorViewDirection:UInt {
    case leftToRight = 0, rightToLeft, topToBottom, bottomToTop
}


@IBDesignable
public class StepIndicatorView: UIView {
    
    // Variables
    static let defaultColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    static let defaultTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    private var annularLayers = [AnnularLayer]()
    private var horizontalLineLayers = [LineLayer]()
    private let containerLayer = CALayer()
    
    
    // MARK: - Overrided properties and methods
    override public var frame: CGRect {
        didSet{
            self.updateSubLayers()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.updateSubLayers()
    }
    
    
    // MARK: - Custom properties
    @IBInspectable public var numberOfSteps: Int = 5 {
        didSet {
            self.createSteps()
        }
    }
    
    @IBInspectable public var currentStep: Int = -1 {
        didSet{
            if self.annularLayers.count <= 0 {
                return
            }
            if oldValue != self.currentStep {
                self.setCurrentStep(step: self.currentStep)
            }
        }
    }
    
    @IBInspectable public var displayNumbers: Bool = false {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleRadius:CGFloat = 10.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleColor:UIColor = defaultColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleTintColor:UIColor = defaultTintColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleStrokeWidth:CGFloat = 3.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineColor:UIColor = defaultColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineTintColor:UIColor = defaultTintColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineMargin:CGFloat = 4.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineStrokeWidth:CGFloat = 2.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    public var direction:StepIndicatorViewDirection = .leftToRight {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable var directionRaw: UInt {
        get{
            return self.direction.rawValue
        }
        set{
            let value = newValue > 3 ? 0 : newValue
            self.direction = StepIndicatorViewDirection(rawValue: value)!
        }
    }
    
    @IBInspectable var showFlag: Bool = true {
        didSet {
            self.updateSubLayers()
        }
    }
    
    // MARK: - Functions
    private func createSteps() {
        if let layers = self.layer.sublayers {
            for layer in layers {
                layer.removeFromSuperlayer()
            }
        }
        self.annularLayers.removeAll()
        self.horizontalLineLayers.removeAll()
        
        if self.numberOfSteps <= 0 {
            return
        }
        
        for i in 0..<self.numberOfSteps {
            let annularLayer = AnnularLayer()
            self.containerLayer.addSublayer(annularLayer)
            self.annularLayers.append(annularLayer)
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = LineLayer()
                self.containerLayer.addSublayer(lineLayer)
                self.horizontalLineLayers.append(lineLayer)
            }
        }
        
        self.layer.addSublayer(self.containerLayer)
        
        self.updateSubLayers()
        self.setCurrentStep(step: self.currentStep)
    }
    
    private func updateSubLayers() {
        self.containerLayer.frame = self.layer.bounds
        
        if self.direction == .leftToRight || self.direction == .rightToLeft {
            self.layoutHorizontal()
        }
        else{
            self.layoutVertical()
        }

        self.applyDirection()
    }
    
    private func layoutHorizontal() {
        let diameter = self.circleRadius * 2
        let stepWidth = self.numberOfSteps == 1 ? 0 : (self.containerLayer.frame.width - self.lineMargin * 2 - diameter) / CGFloat(self.numberOfSteps - 1)
        let y = self.containerLayer.frame.height / 2.0
        
        for i in 0..<self.annularLayers.count {
            let annularLayer = self.annularLayers[i]
            let x = self.numberOfSteps == 1 ? self.containerLayer.frame.width / 2.0 - self.circleRadius : self.lineMargin + CGFloat(i) * stepWidth
            annularLayer.frame = CGRect(x: x, y: y - self.circleRadius, width: diameter, height: diameter)
            self.applyAnnularStyle(annularLayer: annularLayer)
            annularLayer.step = i + 1
            annularLayer.updateStatus()
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = self.horizontalLineLayers[i]
                lineLayer.frame = CGRect(x: CGFloat(i) * stepWidth + diameter + self.lineMargin * 2, y: y - 1, width: stepWidth - diameter - self.lineMargin * 2, height: 3)
                self.applyLineStyle(lineLayer: lineLayer)
                lineLayer.updateStatus()
            }
        }
    }
    
    private func layoutVertical() {
        let diameter = self.circleRadius * 2
        let stepWidth = self.numberOfSteps == 1 ? 0 : (self.containerLayer.frame.height - self.lineMargin * 2 - diameter) / CGFloat(self.numberOfSteps - 1)
        let x = self.containerLayer.frame.width / 2.0
        
        for i in 0..<self.annularLayers.count {
            let annularLayer = self.annularLayers[i]
            let y = self.numberOfSteps == 1 ? self.containerLayer.frame.height / 2.0 - self.circleRadius : self.lineMargin + CGFloat(i) * stepWidth
            annularLayer.frame = CGRect(x: x - self.circleRadius, y: y, width: diameter, height: diameter)
            self.applyAnnularStyle(annularLayer: annularLayer)
            annularLayer.step = i + 1
            annularLayer.updateStatus()
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = self.horizontalLineLayers[i]
                lineLayer.frame = CGRect(x: x - 1, y: CGFloat(i) * stepWidth + diameter + self.lineMargin * 2, width: 3 , height: stepWidth - diameter - self.lineMargin * 2)
                lineLayer.isHorizontal = false
                self.applyLineStyle(lineLayer: lineLayer)
                lineLayer.updateStatus()
            }
        }
    }
    
    private func applyAnnularStyle(annularLayer:AnnularLayer) {
        annularLayer.annularDefaultColor = self.circleColor
        annularLayer.tintColor = self.circleTintColor
        annularLayer.lineWidth = self.circleStrokeWidth
        annularLayer.displayNumber = self.displayNumbers
        annularLayer.showFlag = self.showFlag
    }
    
    private func applyLineStyle(lineLayer:LineLayer) {
        lineLayer.strokeColor = self.lineColor.cgColor
        lineLayer.tintColor = self.lineTintColor
        lineLayer.lineWidth = self.lineStrokeWidth
    }
    
    private func applyDirection() {
        switch self.direction {
        case .rightToLeft:
            let rotation180 = CATransform3DMakeRotation(CGFloat.pi, 0.0, 1.0, 0.0)
            self.containerLayer.transform = rotation180
            for annularLayer in self.annularLayers {
                annularLayer.transform = rotation180
            }
        case .bottomToTop:
            let rotation180 = CATransform3DMakeRotation(CGFloat.pi, 1.0, 0.0, 0.0)
            self.containerLayer.transform = rotation180
            for annularLayer in self.annularLayers {
                annularLayer.transform = rotation180
            }
        default:
            self.containerLayer.transform = CATransform3DIdentity
            for annularLayer in self.annularLayers {
                annularLayer.transform = CATransform3DIdentity
            }
        }
    }
    
    private func setCurrentStep(step:Int) {
        for i in 0..<self.numberOfSteps {
            if i < step {
                if !self.annularLayers[i].isFinished {
                    self.annularLayers[i].isFinished = true
                }
                
                self.setLineFinished(isFinished: true, index: i - 1)
            }
            else if i == step {
                self.annularLayers[i].isFinished = false
                self.annularLayers[i].isCurrent = true
                
                self.setLineFinished(isFinished: true, index: i - 1)
            }
            else{
                self.annularLayers[i].isFinished = false
                self.annularLayers[i].isCurrent = false
                
                self.setLineFinished(isFinished: false, index: i - 1)
            }
        }
    }
    
    private func setLineFinished(isFinished:Bool,index:Int) {
        if index >= 0 {
            if self.horizontalLineLayers[index].isFinished != isFinished {
                self.horizontalLineLayers[index].isFinished = isFinished
            }
        }
    }
}
