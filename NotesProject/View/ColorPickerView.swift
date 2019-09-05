//
//  ColorPickerView.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
    func drawGradient(with rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let rainbowColors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.cyan.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor,
            UIColor.red.cgColor
        ]
        
        let whiteColors = [
            UIColor(white: 1, alpha: 0).cgColor,
            UIColor(white: 1, alpha: 0.3).cgColor,
            UIColor(white: 1, alpha: 1).cgColor
        ]
        
        
        let whiteGradient = CGGradient(
            colorsSpace: colorSpace,
            colors: whiteColors as CFArray,
            locations: nil
        )!
        
        let rainbowGradient = CGGradient(
            colorsSpace: colorSpace,
            colors: rainbowColors as CFArray,
            locations: nil
        )!

        context?.drawLinearGradient(
            rainbowGradient,
            start: CGPoint.zero,
            end: CGPoint(x: self.bounds.width, y: 0),
            options: []
        )
        
        context?.drawLinearGradient(
            whiteGradient,
            start: CGPoint.zero,
            end: CGPoint(x: 0, y: self.bounds.height),
            options: []
        )
    }   
}


protocol HSBColorPickerDelegate : NSObjectProtocol {
    func HSBColorColorPickerTouched(sender: ColorPickerView, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State)
}

@IBDesignable
class ColorPickerView: UIView {
    
    @IBInspectable var color: UIColor!
    
    override func draw(_ rect: CGRect) {
        
    }
}
