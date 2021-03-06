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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionAuto(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
            sender.pulsate(sender.isSelected)
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        sender.pulsate(true)
    }
    
    @IBAction func touchUpOut(_ sender: UIButton) {
        sender.pulsate(false)
    }
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        sender.pulsate(false)
    }
    
}


