//
//  extensions.swift
//  Gaadi
//
//  Created by Ashish Sharma on 22/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreBluetooth

extension CBUUID {
    //mBot services
    @nonobjc static let transDataService = CBUUID(string:"FFF0")
    @nonobjc static let transDataDualService = CBUUID(string:"FFE1")
    
    //Service characteristics
    @nonobjc static let transDataCharateristic = CBUUID(string:"FFF1")
    @nonobjc static let transDataDualCharateristic = CBUUID(string:"FFE3")
    @nonobjc static let notifyDataCharateristic = CBUUID(string:"FFF4")
    @nonobjc static let notifyDataDualCharateristic = CBUUID(string:"FFE2")
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
