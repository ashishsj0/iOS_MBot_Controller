//
//  BluetoothDevice.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothConnectionHandler: NSObject, CBCentralManagerDelegate  {
    
    static let sharedInstance = BluetoothConnectionHandler()
    private var centralManager: CBCentralManager!
    var peripherals: [CBPeripheral] = []
    
    var isScanning: Bool {
        get {
            return centralManager.isScanning
        }
    }
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scan(comp: (_ result: String) -> ()) {
        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
        
    }
    
    func scanDevices(status: @escaping([CBPeripheral],BLErrors?) -> Void) {
        self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            if self.peripherals.count > 0 {
                status(self.peripherals,nil)
            }
        })

    }
    
    func cancelScan(status: (Bool,BLErrors?) -> Void) {
        self.centralManager.stopScan()
    }
    
    func endConnection(_ peripheralDevice: CBPeripheral,status: @escaping(Bool) -> Void) {
        self.centralManager.cancelPeripheralConnection(peripheralDevice)
    }
    
    func connectToDevice(_ peripheralDevice: CBPeripheral, _ options: [String:Any]? = nil) {
        self.centralManager.connect(peripheralDevice, options: options)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print(peripheral.name)
        
        if peripheral.name?.contains("Makeblock") ?? false {
            self.centralManager.stopScan()
            self.peripherals.append(peripheral)
        
        }

    }
    
    
}

class BluetoothDevice {
    
    var name: String = ""
    
}

enum BLErrors: String {
    
    case failure = "Failed to connect"
    case notFound = "No Devices Found"
    
}

