//
//  UIViewExtensions.swift
//  Gaadi
//
//  Created by Ashish Sharma on 17/05/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func flash(_ start:Bool) {
        let flash = CABasicAnimation(keyPath: "opacity")
        if start {
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = .infinity
        layer.add(flash, forKey: nil)
        } else {
            layer.removeAllAnimations()
        }}
    
    func pulsate(_ start:Bool) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        if start {
            pulse.duration = 0.4
            pulse.fromValue = 0.80
            pulse.toValue = 1.0
            pulse.autoreverses = true
            pulse.repeatCount = .infinity
            pulse.initialVelocity = 0.5
            pulse.damping = 1.0
            layer.add(pulse, forKey: nil)
        } else {
            layer.removeAllAnimations()
        }}
}
