//
//  ArduinoController.swift
//  Gaadi
//
//  Created by Ashish Sharma on 27/04/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class ArduinoController {
    
    static let sharedInstance = ArduinoController()
    
    func autoMode(_ on: Bool = false) {}
    func moveAhead() {}
    func moveBack() {}
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
