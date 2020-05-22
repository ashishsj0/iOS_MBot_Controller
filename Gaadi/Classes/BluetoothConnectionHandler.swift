//
//  BluetoothDevice.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BluetoothConnectionHandlerProtocol {
    func didConnect(device: CBPeripheral)
    func didDisconnect(device: CBPeripheral)
    func didReceiveValue(_ value: Int8)
}

class BluetoothConnectionHandler: NSObject  {
    
    private static let sharedInstance = BluetoothConnectionHandler()
    private var centralManager: CBCentralManager!
    var delegate: BluetoothConnectionHandlerProtocol?
    var connectedPeripheral: CBPeripheral?
    var targetService: CBService?
    var writableCharacteristic: CBCharacteristic?
    var peripherals: [CBPeripheral] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    class func shared() -> BluetoothConnectionHandler {
        return sharedInstance
    }
    
    public func isScanning() -> Bool {
        return self.centralManager.isScanning
    }
    
    func scan(comp: (_ result: String) -> ()) {
        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func scanDevices(status: @escaping([CBPeripheral]) -> Void) {
        self.peripherals = []
        
        self.centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            if self.peripherals.count > 0 {
                status(self.peripherals)
            }
        })

    }
    
    func cancelScan() {
        self.centralManager.stopScan()
    }
    
    func connectToDevice(_ peripheralDevice: CBPeripheral, _ options: [String:Any]? = nil) {
           self.centralManager.connect(peripheralDevice, options: options)
       }
    
    func endConnection(_ peripheralDevice: CBPeripheral) {
        self.centralManager.cancelPeripheralConnection(peripheralDevice)

    }
}

//MARK: Central manager Delegate

extension BluetoothConnectionHandler: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripheral.name?.contains("Makeblock") ?? false {
            self.centralManager.stopScan()
            self.peripherals.append(peripheral)
        
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.connectedPeripheral = peripheral
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        self.delegate?.didConnect(device: peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.connectedPeripheral = nil
        self.delegate?.didDisconnect(device: peripheral)
    }
    
    
}

//MARK: Peripheral Delegate

extension BluetoothConnectionHandler : CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            return
        }

        targetService = services.first
        if let service = services.first {
            targetService = service
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            return
        }

        for characteristic in characteristics {
            if characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse) {
                writableCharacteristic = characteristic
            }
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }

    // RX functions
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value, let del = delegate else {
            return
        }
        
        del.didReceiveValue( data.int8Value() )
    }
}

