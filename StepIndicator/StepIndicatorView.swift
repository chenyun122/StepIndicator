//
//  StepIndicatorView.swift
//  StepIndicator
//
//  Created by Yun Chen on 2017/7/14.
//  Copyright © 2017 Yun CHEN. All rights reserved.
//

import UIKit

@IBDesignable
public class StepIndicatorView: UIView {
    
    // Variables
    static let defaultColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    static let defaultTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    private var annularLayers = [AnnularLayer]()
    private var horizontalLineLayers = [HorizontalLineLayer]()
    
    
    // MARK: - Properties
    override public var frame: CGRect {
        didSet{
            self.updateSubLayers()
        }
    }
    
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
            self.layer.addSublayer(annularLayer)
            self.annularLayers.append(annularLayer)
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = HorizontalLineLayer()
                self.layer.addSublayer(lineLayer)
                self.horizontalLineLayers.append(lineLayer)
            }
        }
        
        self.updateSubLayers()
        self.setCurrentStep(step: self.currentStep)
    }
    
    private func updateSubLayers() {
        let diameter = self.circleRadius * 2
        let stepWidth = self.numberOfSteps == 1 ? 0 : (self.layer.frame.width - self.lineMargin * 2 - diameter) / CGFloat(self.numberOfSteps - 1)
        let y = self.layer.frame.height / 2.0
        
        for i in 0..<self.annularLayers.count {
            let annularLayer = self.annularLayers[i]
            let x = self.numberOfSteps == 1 ? self.frame.width / 2.0 - self.circleRadius : self.lineMargin + CGFloat(i) * stepWidth
            annularLayer.frame = CGRect(x: x, y: y - self.circleRadius, width: diameter, height: diameter)
            annularLayer.annularDefaultColor = self.circleColor
            annularLayer.tintColor = self.circleTintColor
            annularLayer.lineWidth = self.circleStrokeWidth
            annularLayer.displayNumber = self.displayNumbers
            annularLayer.step = i + 1
            annularLayer.updateStatus()
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = self.horizontalLineLayers[i]
                lineLayer.frame = CGRect(x: CGFloat(i) * stepWidth + diameter + self.lineMargin * 2, y: y - 1, width: stepWidth - diameter - self.lineMargin * 2, height: 3)
                lineLayer.strokeColor = self.lineColor.cgColor
                lineLayer.tintColor = self.lineTintColor
                lineLayer.lineWidth = self.lineStrokeWidth
                lineLayer.updateStatus()
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
