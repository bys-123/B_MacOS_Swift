//
//  AppDelegate.swift
//  macos-swift-build
//
//  Created by bys on 13/02/2018.
//  Copyright © 2018 bys. All rights reserved.
//

import Cocoa
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterPush
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, MSPushDelegate, MSCrashesDelegate{



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        MSPush.setDelegate(self)
        MSCrashes.setDelegate(self)
        //MSAppCenter.setLogUrl("https://in-staging-south-centralus.staging.avalanch.es")
        MSAppCenter.start("57597aa8-f08b-48fb-86c3-03ccece82b8b", withServices:[
            MSAnalytics.self,
            MSCrashes.self,
            MSPush.self
            ])
        MSAnalytics.trackEvent("Launch")
        var customProperties = MSCustomProperties()
        customProperties.setString("red", forKey: "color")
        customProperties.setNumber(11, forKey: "score")
        customProperties.setBool(true, forKey: "bool")
        MSAppCenter.setCustomProperties(customProperties)
        var install = MSAppCenter.installId()
        
        MSCrashes.setUserConfirmationHandler({ (errorReports: [MSErrorReport]) in
            
            // Your code to present your UI to the user, e.g. an NSAlert.
            let alert: NSAlert = NSAlert()
            alert.messageText = "Sorry about that!"
            alert.informativeText = "Do you want to send an anonymous crash report so we can fix the issue?"
            alert.addButton(withTitle: "Always send")
            alert.addButton(withTitle: "Send")
            alert.addButton(withTitle: "Don't send")
            alert.alertStyle = NSWarningAlertStyle
            
            switch (alert.runModal()) {
            case NSAlertFirstButtonReturn:
                MSCrashes.notify(with: .always)
                break;
            case NSAlertSecondButtonReturn:
                MSCrashes.notify(with: .send)
                break;
            case NSAlertThirdButtonReturn:
                MSCrashes.notify(with: .dontSend)
                break;
            default:
                break;
            }
            
            return true // Return true if the SDK should await user confirmation, otherwise return false.
        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func push(_ push: MSPush!, didReceive pushNotification: MSPushNotification!) {
        let title: String = pushNotification.title ?? ""
        var message: String = pushNotification.message ?? ""
        var customData: String = ""
        for item in pushNotification.customData {
            customData =  ((customData.isEmpty) ? "" : "\(customData), ") + "\(item.key): \(item.value)"
        }
        message =  message + ((customData.isEmpty) ? "" : "\n\(customData)")
        let alert: NSAlert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

}

