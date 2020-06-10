//
//  ArduinoController.swift
//  Gaadi
//
//  Created by Ashish Sharma on 27/04/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreBluetooth

class ArduinoController {
    
    private static let sharedInstance = ArduinoController()
    
    class func shared() -> ArduinoController {
        return sharedInstance
    }
    
    func writeValue(value: Int16) {
        
        guard let peripheral = BluetoothConnectionHandler.shared().connectedPeripheral, let characteristic = BluetoothConnectionHandler.shared().writableCharacteristic else {
            return
        }
        
        var d = value
        
        let data = Data(buffer: UnsafeBufferPointer(start: &d, count: 1))
        BluetoothConnectionHandler.shared().send(data: data)
    }
    
    func autoMode(_ on: Bool = false) {}
   
    func moveAhead() {
       self.writeValue(value: 1)
    }
    
    func moveBack() {
        self.writeValue(value: 2)
    }
    
    func turnLeft() {
        self.writeValue(value: 3)
    }
    
    func turnRight() {
        self.writeValue(value: 4)
    }
    func stop() {
        self.writeValue(value: 5)
    }
    
    func honk() {}
}
