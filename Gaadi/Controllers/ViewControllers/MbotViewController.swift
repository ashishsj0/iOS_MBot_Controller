//
//  ViewController.swift
//  Gaadi
//
//  Created by Ashish Sharma on 27/04/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class MbotViewController: UIViewController {
    
    @IBOutlet weak var btnAuto: UIButton!
    @IBOutlet weak var imgLeftRight: UIImageView!
    @IBOutlet weak var imgUpDown: UIImageView!
    
    let sharedArduinoController: ArduinoController = ArduinoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionAuto(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.pulsate(sender.isSelected)
        sharedArduinoController.autoMode(sender.isSelected)
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        sender.pulsate(true)
        self.moves(sender.tag)
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
            sharedArduinoController.turnLeft()
            break;
        case 02:
            sharedArduinoController.turnRight()
            break;
        case 03:
            sharedArduinoController.moveAhead()
            break;
        case 04:
            sharedArduinoController.moveBack()
            break;
        default:
            break
        }
    }
    
}


