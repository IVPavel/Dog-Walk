//
//  AppDelegate.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var coreDataStack = CoreDataStack(modelName: "Dog Walk")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let viewController = navigationController.topViewController as? ViewController else {
                return true
        }

        viewController.managedContext = coreDataStack.managerContext
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }


}

