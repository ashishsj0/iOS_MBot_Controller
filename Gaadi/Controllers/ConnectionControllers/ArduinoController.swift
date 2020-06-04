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
    
    func writeValue(value: Int8) {
        guard let peripheral = BluetoothConnectionHandler.shared().connectedPeripheral, let characteristic = BluetoothConnectionHandler.shared().writableCharacteristic else {
            return
        }
        
        let data = Data.dataWithValue(value: value)

        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
    
    func writeValueString(value: String) {
        guard let peripheral = BluetoothConnectionHandler.shared().connectedPeripheral, let characteristic = BluetoothConnectionHandler.shared().writableCharacteristic else {
            return
        }

        peripheral.writeValue(value.data(using: .utf8)!, for: characteristic, type: .withResponse)
    }
    
    func autoMode(_ on: Bool = false) {}
   
    func moveAhead() {
       self.writeValueString(value: "1")
        //(value: 1)
    }
    func moveBack() {
        self.writeValueString(value: "2")
        //self.writeValue(value: 2)
    }
    func turnLeft() {
        self.writeValue(value: 3)
    }
    func turnRight() {
        self.writeValue(value: 4)
    }
    func honk() {}
}

enum Port: UInt8 {
    case PORT_0 = 0x00
    case PORT_1 = 0x01
    case PORT_2 = 0x02
    case PORT_3 = 0x03
    case PORT_4 = 0x04
    case M1 = 0x09
    case M2 = 0x0A
}

