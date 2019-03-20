//
//  main.swift
//  Task
//
//  Created by Habibur Rahman on 20/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)

