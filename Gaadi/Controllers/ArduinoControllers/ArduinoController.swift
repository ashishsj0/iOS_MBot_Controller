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
    
    func autoMode(_ on: Bool = false) {}
    func moveAhead() {
        
       
    }
    func moveBack() {
        
        self.writeValue(value: 1)
        
    }
    func turnLeft() {}
    func turnRight() {}
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

extension Data {
    static func dataWithValue(value: Int8) -> Data {
        var variableValue = value
        return Data(buffer: UnsafeBufferPointer(start: &variableValue, count: 1))
    }

    func int8Value() -> Int8 {
        return Int8(bitPattern: self[0])
    }
}
