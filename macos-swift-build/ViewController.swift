//
//  ViewController.swift
//  macos-swift-build
//
//  Created by bys on 13/02/2018.
//  Copyright © 2018 bys. All rights reserved.
//

import Cocoa
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func Crash(_ sender: NSButton) {
    MSCrashes.generateTestCrash()
    }
    @IBAction func event1(_ sender: NSButton) {
    MSAnalytics.trackEvent("event1", withProperties: ["Category" : "Music", "FileName" : "favorite.avi"])    }
    @IBAction func event2(_ sender: NSButton) {
    MSAnalytics.trackEvent("event2", withProperties: ["Category" : "Musicetrutyurtgdfhbfgbv436FDSGFJGHJTJTYJJGHJDGJHGJGDJGDJDGJHGJcvnfngnbvcbvbfgnfbdfbdbfbbcvb"])    }
}

