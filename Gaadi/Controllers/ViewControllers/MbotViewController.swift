//
//  ViewController.swift
//  Gaadi
//
//  Created by Ashish Sharma on 27/04/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import CoreBluetooth

class MbotViewController: UIViewController {
    
    @IBOutlet weak var btnAuto: UIButton!
    @IBOutlet weak var imgLeftRight: UIImageView!
    @IBOutlet weak var imgUpDown: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        guard let peripheral = BluetoothConnectionHandler.shared().connectedPeripheral else {
            return
        }
        BluetoothConnectionHandler.shared().endConnection(peripheral)

    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAuto(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.pulsate(sender.isSelected)
        ArduinoController.shared().autoMode(sender.isSelected)
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        sender.pulsate(true)
        self.moves(sender.tag)
        
        ArduinoController.shared().moveBack()
    }
    
    @IBAction func touchUpOut(_ sender: UIButton) {
        sender.pulsate(false)
        self.moves(sender.tag)
    }
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        sender.pulsate(false)
        self.moves(sender.tag)
    }
    
    func moves(_ tag: Int) {
        switch tag {
        case 01:
            ArduinoController.shared().turnLeft()
            break;
        case 02:
            ArduinoController.shared().turnRight()
            break;
        case 03:
            ArduinoController.shared().moveAhead()
            break;
        case 04:
            ArduinoController.shared().moveBack()
            break;
        default:
            break
        }
    }
    
}

extension MbotViewController: BluetoothConnectionHandlerProtocol {
    func didReceiveValue(_ value: Int8) {
        
    }
    
    func didDisconnect(device: CBPeripheral) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didConnect(device: CBPeripheral) {
    
    }
}


