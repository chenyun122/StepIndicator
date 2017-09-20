# StepIndicator



StepIndicator is an iOS library that indicates steps in an animated way.  
Writen in Swift 3.2 , and Swfit 4.0 is supported.  
Derived from the awesome Android version: https://github.com/badoualy/stepper-indicator  
<p align="center" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/StepIndicator.gif" alt="StepIndicator" title="StepIndicator" width="35%" height="35%">
</p>

## Installation
###  CocoaPods
Coming soon

###  Manually
You could directly copy and add the folder `StepIndicator` to your project.   


## Usage
You could use `StepIndicatorView` like you use `UIView`, create and set it programmatically, or get everything done with Storyboard and XIB.
Please clone this Demo project to find out how it's working easily.
### Programmatically
```swift
    //......
    let stepIndicatorView = StepIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepIndicatorView.frame = CGRect(x: 0, y: 50, width: 280, height: 100)
        self.view.addSubview(self.stepIndicatorView)
        
        self.stepIndicatorView.numberOfSteps = 5
        self.stepIndicatorView.currentStep = 0
    }
    //......
```
### Customization
```swift
    self.stepIndicatorView.circleColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    self.stepIndicatorView.circleTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    self.stepIndicatorView.circleStrokeWidth = 3.0
    self.stepIndicatorView.circleRadius = 10.0
    self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
    self.stepIndicatorView.lineTintColor = self.stepIndicatorView.circleTintColor
    self.stepIndicatorView.lineMargin = 4.0
    self.stepIndicatorView.lineStrokeWidth = 2.0
```

### Designable in Stroyboard and Xib
<p align="left" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Designable.gif" alt="Designable" title="Designable" width="90%" height="90%">
</p>




## License
StepIndicator is released under the MIT license. See LICENSE for details.

