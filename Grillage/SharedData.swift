//
//  SharedData.swift
//  Grillage
//
//  Created by Vincent on 03/07/2016.
//  Copyright © 2016 Vincent. All rights reserved.
//

import Foundation

class ShareData {
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ShareData()
        }
        
        return Static.instance!
    }
    
    
    var lon : Double!
    
    var lat : Double!
    
    var newPadlock : AnyObject!
    
    var existNewPadlock : Bool!
    
}