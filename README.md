# StepIndicator 

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/StepIndicator.svg)](https://img.shields.io/cocoapods/v/StepIndicator.svg)
[![Platform](https://img.shields.io/cocoapods/p/StepIndicator.svg?style=flat)](http://cocoadocs.org/docsets/StepIndicator)

[简体中文](https://github.com/chenyun122/StepIndicator/blob/master/README_CN.md)  

StepIndicator is an iOS library that indicates steps in an animated way.   
Writen in Swift 3.2 , and Swfit 4.0 is supported.  
The idea and design are derived from the awesome Android version: https://github.com/badoualy/stepper-indicator  

<p align="center" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshots/StepIndicator.gif" alt="StepIndicator" title="StepIndicator" width="35%" height="35%" />
</p>

<p align="center" >
Numbers supported:<br/>
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshots/Screenshot_numbers.png" alt="StepIndicator Numbers" title="StepIndicator Numbers" width="35%" height="35%" />
</p>

## Installation
###  CocoaPods
To integrate StepIndicator into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'YourProjectName' do
   pod ‘StepIndicator’, '~> 1.0.5’
end
```
And then remember to `import StepIndicator` module before using it.

###  Manually
You could directly copy and add the folder `StepIndicator` which contains 'StepIndicatorView.swift' file to your project.   


## Usage
You could use `StepIndicatorView` like you use `UIView`, create and layout it programmatically, or get everything done with Storyboard and XIB. Additionally, clone this [Demo](https://github.com/chenyun122/StepIndicator) project to find out how easy it is working. It also provides a way to cooperate with UIScrollView.
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

### Customization (Optional)
Values of following properties have been set as defaults already. Change them if they are not suitable for you.
```swift
    self.stepIndicatorView.circleColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    self.stepIndicatorView.circleTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    self.stepIndicatorView.circleStrokeWidth = 3.0
    self.stepIndicatorView.circleRadius = 10.0
    self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
    self.stepIndicatorView.lineTintColor = self.stepIndicatorView.circleTintColor
    self.stepIndicatorView.lineMargin = 4.0
    self.stepIndicatorView.lineStrokeWidth = 2.0
    self.stepIndicatorView.displayNumbers = false //indicates if it displays numbers at the center instead of the core circle
```

### Designable in Stroyboard and Xib (Optional)
After adding a `UIView` to Stroyboard or Xib, change its class to `StepIndicatorView`. Then you are able to config it as this demonstration:
<p align="left" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshots/Designable.gif" alt="Designable" title="Designable" width="90%" height="90%">
</p>

## Help
Hope you will enjoy it! Feel free to make an issue to me if you have any problems or need some improvements. And Please give the project a **star** if it's helpful to you, that's a great encouragement to me! ;)

## License
StepIndicator is released under the MIT license. See LICENSE for details.

