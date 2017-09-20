Pod::Spec.new do |s|
  s.name         = "StepIndicator"
  s.version      = "1.0.1"
  s.summary      = "An iOS Step Indicator Library."
  s.description  = <<-DESC
                    StepIndicator is an iOS library that indicates steps in an animated way.
                   DESC
  s.homepage     = "https://github.com/chenyun122/StepIndicator"
  s.screenshots  = "https://raw.githubusercontent.com/chenyun122/StepIndicator/master/Screenshot.png"
  s.license      = "MIT"
  s.author       = { "Yun Chen" => "chenyun122@gmail.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/chenyun122/StepIndicator.git", :tag => "#{s.version}" }
  s.source_files  = "StepIndicator", "StepIndicator/**/*.swift"
  s.resource_bundles = {
    'StepIndicator' => ['StepIndicator/**/*.xcassets']
  }
end
