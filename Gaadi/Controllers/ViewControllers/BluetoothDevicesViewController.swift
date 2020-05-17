//
//  BluetoothDevicesViewController.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class BluetoothDevicesViewController: UIViewController {

    var devices: [BluetoothDevice] = []

    var bluetoothHandler: BluetoothConnectionHandler = BluetoothConnectionHandler()
    
    @IBAction func scanDevices(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.titleLabel?.text = !sender.isSelected ? (" Start Scan") : ("Stop Scan")
        !sender.isSelected ? bluetoothHandler.scanDevices() :
        bluetoothHandler.cancelScan()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Table View

extension BluetoothDevicesViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BluetoothDeviceTableViewCell") as! BluetoothDeviceTableViewCell
        cell.lblDeviceName.text = devices[indexPath.row].name
        cell.delegate = self
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
        
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


