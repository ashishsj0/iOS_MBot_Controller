//
//  BluetoothDevice.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothConnectionHandler {
    
    static let sharedInstance = BluetoothConnectionHandler()
    
    func scanDevices() {
        
    }
    
    func cancelScan() {
        
    }
    
    func endConnection() {
        
    }
    
    func connectToDevice() {
        
    }
    
}

class BluetoothDevice {
    
    var name: String = ""
    
}

enum errors: String {
    
    case failure = "Failed to connect"
    case notFound = "No Devices Found"
    
}

