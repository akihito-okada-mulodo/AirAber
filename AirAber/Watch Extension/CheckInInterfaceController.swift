//
//  CheckInInterfaceController.swift
//  AirAber
//
//  Created by Okada Akihito on 2015/12/17.
//  Copyright © 2015年 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class CheckInInterfaceController: WKInterfaceController {
    
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        if let flight = context as? Flight { self.flight = flight }
    }
    
    @IBAction func checkInButtonTapped() {
        // 1
        let duration = 0.35
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64((duration + 0.15) * Double(NSEC_PER_SEC)))
        // 2
        backgroundGroup.setBackgroundImageNamed("Progress")
        // 3
        backgroundGroup.startAnimatingWithImagesInRange(NSRange(location: 0, length: 10), duration: duration, repeatCount: 1)
        // 4
        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
            // 5
            self.flight?.checkedIn = true
            self.dismissController()
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    var flight: Flight? {
        didSet {
            if let flight = flight {
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
            }
        }
    }

}
