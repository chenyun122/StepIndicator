# StepIndicator [English](https://github.com/chenyun122/StepIndicator)

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/StepIndicator.svg)](https://img.shields.io/cocoapods/v/StepIndicator.svg)
[![Platform](https://img.shields.io/cocoapods/p/StepIndicator.svg?style=flat)](http://cocoadocs.org/docsets/StepIndicator)

StepIndicator 是一个以较为生动的方式指示任务步骤的 iOS 库。由 Swift3.2 书写，支持 Swift4.0 。  
它的设计思想来源于此 Android 版本: https://github.com/badoualy/stepper-indicator  

<p align="center" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshots/StepIndicator.gif" alt="StepIndicator" title="StepIndicator" width="35%" height="35%" />
</p>

<p align="center" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshots/Screenshot_numbers.png" alt="StepIndicator Numbers" title="StepIndicator Numbers" width="35%" height="35%" />
</p>

## 安装
###  CocoaPods
在 Xcode 项目中通过 CocoaPods 集成 StepIndicator,只需在 `Podfile` 文件中指定以下内容:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'YourProjectName' do
   pod ‘StepIndicator’, '~> 1.0.3’
end
```
集成之后，记得在使用前先通过 `import StepIndicator` 导入该模块。

###  手动
把包含 `StepIndicatorView.swift` 文件的源码文件夹 `StepIndicator` 复制到您项目的相应目录下，再在 Xcode 加入该文件夹即可。


## 如何使用
您可以像使用 `UIView` 那样使用 `StepIndicatorView` ，通过编程方式创建和进行布局，或在 Storyboard 和 XIB 中搞定界面配置。另外，可以通过克隆此 [Demo](https://github.com/chenyun122/StepIndicator) 项目了解如何方便地使用它。Demo项目中也展示了如何响应UIScrollView的翻页事件，并设置步骤。

### 编程方式
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

### 界面定制化 (可选)
以下示例中的属性值已是默认值，如果默认界面符合您的要求，可以忽略这部分。如果它们不满足您的需要，可以按以下方式改变属性值:
```swift
    self.stepIndicatorView.circleColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    self.stepIndicatorView.circleTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    self.stepIndicatorView.circleStrokeWidth = 3.0
    self.stepIndicatorView.circleRadius = 10.0
    self.stepIndicatorView.lineColor = self.stepIndicatorView.circleColor
    self.stepIndicatorView.lineTintColor = self.stepIndicatorView.circleTintColor
    self.stepIndicatorView.lineMargin = 4.0
    self.stepIndicatorView.lineStrokeWidth = 2.0
    self.stepIndicatorView.displayNumbers = false //indicates if it displays numbers in center instead of core circle
```

### 支持在 Stroyboard 和 Xib 中直接配置 (可选)
先往 Stroyboard 或 Xib 中增加一个 `UIView`,然后把类变更为 `StepIndicatorView` 。等 Xcode 预加载完控件后，就可以按下图所示进行配置:
<p align="left" >
<img src="https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshots/Designable.gif" alt="Designable" title="Designable" width="90%" height="90%">
</p>

希望此库能给您带来帮助！如果您碰到使用问题，或需要增加一些功能，请提 issue 给我。

## 许可
StepIndicator 基于 MIT 许可发布， 详情请参见 LICENSE 文件。

