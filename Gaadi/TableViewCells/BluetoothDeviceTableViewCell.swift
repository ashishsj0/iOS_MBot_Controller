//
//  BluetoothDeviceTableViewCell.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol BluetoothDeviceTableViewCellProtocol {
    func btnConnectTappedAtRow(_ row: Int)
}

class BluetoothDeviceTableViewCell: UITableViewCell {

    var delegate: BluetoothDeviceTableViewCellProtocol? = nil
    
    @IBOutlet weak var lblDeviceName: UILabel!
    
    @IBOutlet weak var btnConnect: UIButton!
    
    @IBAction func btnConnectTapped(_ sender: UIButton) {
        self.delegate?.btnConnectTappedAtRow(sender.tag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
