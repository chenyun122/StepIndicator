//
//  Created by ChenYun on 2019/8/28.
//  Copyright © 2019 ChenYun. All rights reserved.
//

import PackageDescription

let package = Package(name: "StepIndicator",
                      platforms: [.iOS(.v8)],
                      products: [.library(name: "StepIndicator",
                                          targets: ["StepIndicator"])],
                      targets: [.target(name: "StepIndicator",
                                        path: "StepIndicator")],
                      swiftLanguageVersions: [.v5])