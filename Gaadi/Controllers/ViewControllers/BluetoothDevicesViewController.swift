//
//  BluetoothDevicesViewController.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothDevicesViewController: UIViewController {
        
    var peripherals: [CBPeripheral] = []
    
    @IBOutlet weak var imgScan: UIImageView!
    @IBOutlet weak var tblDevices: UITableView!
    
  //  var uuid = CBUUID.init(string: "0x00000002826152e0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblDevices.dataSource = self
        self.tblDevices.delegate = self
        BluetoothConnectionHandler.shared().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if BluetoothConnectionHandler.shared().connectedPeripheral != nil {
            if self.peripherals.contains(BluetoothConnectionHandler.shared().connectedPeripheral!) {
                print("device already connected.")
            }
        }
    }
    
    @IBAction func scanDevices(_ sender: UIButton) {
        
        if BluetoothConnectionHandler.shared().isScanning {
            BluetoothConnectionHandler.shared().cancelScan { status, err in
                sender.titleLabel?.text = status ? ("Scan") : ("Cancel")
                status ? self.imgScan.pulsate(false) : self.imgScan.pulsate(true)
            }}
            else {
            self.imgScan.pulsate(true)
            sender.titleLabel?.text = "Cancel"
            BluetoothConnectionHandler.shared().scanDevices { devicesFound, err in
                sender.titleLabel?.text = devicesFound.isEmpty ? ("Scan") : ("Cancel")
                if devicesFound.isEmpty {
                    self.imgScan.pulsate(true)
                }
                else { self.imgScan.pulsate(false)
                    self.peripherals = devicesFound
                    self.tblDevices.reloadData()
                }
            }
            }
    }
    
    
    func openControllerViewController() {
    
        let vc =  storyboard?.instantiateViewController(identifier: "MbotViewController") as! MbotViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: Table View

extension BluetoothDevicesViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BluetoothDeviceTableViewCell") as! BluetoothDeviceTableViewCell
        cell.delegate = self
        cell.lblDeviceName.text = peripherals[indexPath.row].name ?? "____________"
        cell.btnConnect.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: Handling the connect button

extension BluetoothDevicesViewController: BluetoothDeviceTableViewCellProtocol {
   
    func btnConnectTappedAtRow(_ row: Int) {
        BluetoothConnectionHandler.shared().connectToDevice(self.peripherals[row])
    }
}

// MARK: Handling bluetooth connection events

extension BluetoothDevicesViewController: BluetoothConnectionHandlerProtocol {
    func didReceiveValue(_ value: Int8) {
        
    }
    
    func didDisconnect(device: CBPeripheral) {
    
    }
    
    func didConnect(device: CBPeripheral) {
        self.openControllerViewController()
    }
}
