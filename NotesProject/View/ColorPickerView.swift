//
//  ColorPickerView.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit
import CoreGraphics

class Color {
    static func drawGradient(for view: UIView, with rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.cyan.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor,
            UIColor.red.cgColor
        ]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: nil
            )!
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: view.bounds.width, y: 0)
        context?.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
    }   
}


@IBDesignable
class ColorPickerView: UIView {
    
    @IBInspectable var color: UIColor!
    
    override func draw(_ rect: CGRect) {
        
    }
}
