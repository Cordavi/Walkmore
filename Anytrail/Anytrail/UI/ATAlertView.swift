//
//  ATAlertView.swift
//  Anytrail
//
//  Created by Ryan Cohen on 8/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ATAlertView {
    
//    struct ATAlertViewColor {
//        static let GREY = UIColorFromHex(0xE3E7EA, alpha: 0.9)
//        static let RED = UIColorFromHex(0xE74C3C, alpha: 0.9)
//        static let GREEN = UIColorFromHex(0x27AE60, alpha: 0.9)
//    }
    
    enum ATAlertViewType: Int {
        case Normal = 1
        case Error = 2
        case Success = 3
        case Origin = 4
        case PointOfInterest = 5
    }
    
    class func alertWithTitle(controller: UIViewController, type: ATAlertViewType, title: String, text: String, callback: () -> Void) {
        let color: UIColor
        
        if type == .Normal {
            color = ATConstants.Colors.GRAY
        } else if type == .Error {
            color = ATConstants.Colors.RED
        } else if type == .Success {
            color = ATConstants.Colors.GREEN
        } else if type == .PointOfInterest {
            color = ATConstants.Colors.ORANGE
        } else {
            color = ATConstants.Colors.BLUE
        }
        
        let alert = JSSAlertView().show(
            controller,
            title: title,
            text: text,
            buttonText: "Dismiss",
            color: color
        )
        
        alert.addAction(callback)
        alert.setTextTheme(.Light)
    }
    
    class func alertWithConfirmationForVenue(controller: UIViewController, image: UIImage, title: String, text: String, action: String, callback: () -> Void, cancelCallback: () -> Void) {
        let color: UIColor
        
        if action == "Add" {
            color = ATConstants.Colors.ORANGE
        } else {
            color = ATConstants.Colors.RED
        }
        
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let alert = JSSAlertView().show(
            controller,
            title: title,
            iconImage: scaledImage,
            text: text,
            buttonText: action,
            cancelButtonText: "Cancel",
            color: color
        )
        
        alert.addAction(callback)
        alert.addCancelAction(cancelCallback)
        alert.setTextTheme(.Light)
    }
    
    class func alertWithConfirmation(controller: UIViewController, title: String, text: String, action: String, callback: () -> Void, cancelCallback: () -> Void) {
        let color: UIColor

        if action == "Add" {
            color = ATConstants.Colors.GREEN
        } else {
            color = ATConstants.Colors.RED
        }
        
        let alert = JSSAlertView().show(
            controller,
            title: title,
            text: text,
            buttonText: action,
            cancelButtonText: "Cancel",
            color: color
        )
        
        alert.addAction(callback)
        alert.addCancelAction(cancelCallback)
        alert.setTextTheme(.Light)
    }
    
    class func alertNetworkLoss(controller: UIViewController, callback: () -> Void) {
        let alert = JSSAlertView().show(
            controller,
            title: "Oh no!",
            iconImage: UIImage(named: "connection"),
            text: "Looks like you've lost connection to the internet.",
            buttonText: "Dismiss",
            color: ATConstants.Colors.RED
        )
        
        alert.addAction(callback)
        alert.setTextTheme(.Light)
    }
}