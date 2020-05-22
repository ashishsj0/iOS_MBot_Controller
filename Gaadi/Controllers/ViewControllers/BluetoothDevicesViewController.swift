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
            
        }
    }
    
    @IBAction func scanDevices(_ sender: UIButton) {
        
        if BluetoothConnectionHandler.shared().isScanning() {
            BluetoothConnectionHandler.shared().cancelScan()
            
            DispatchQueue.main.async {
                sender.titleLabel?.text = "scan"
                self.imgScan.pulsate(false)
            }

        }
        else {
            DispatchQueue.main.async {
                            self.imgScan.pulsate(true)
                            sender.titleLabel?.text = "cancel"
                       }
            BluetoothConnectionHandler.shared().scanDevices { devicesFound in
                 DispatchQueue.main.async {
                    sender.titleLabel?.text = "scan"
                    self.imgScan.pulsate(false)
                    self.tblDevices.reloadData()
                }}
           
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
        return BluetoothConnectionHandler.shared().peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BluetoothDeviceTableViewCell") as! BluetoothDeviceTableViewCell
        cell.delegate = self
        cell.lblDeviceName.text = BluetoothConnectionHandler.shared().peripherals[indexPath.row].name ?? "____________"
        cell.btnConnect.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

// MARK: Handling the connect button

extension BluetoothDevicesViewController: BluetoothDeviceTableViewCellProtocol {
    
    func btnConnectTappedAtRow(_ row: Int) {
        BluetoothConnectionHandler.shared().connectToDevice(BluetoothConnectionHandler.shared().peripherals[row])
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
