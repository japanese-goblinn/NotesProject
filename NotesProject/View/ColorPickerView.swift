//
//  ColorPickerView.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit
import CoreGraphics

protocol HSBColorPickerDelegate : NSObjectProtocol {
    func HSBColorColorPickerTouched(sender: ColorPickerView, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State)
}

@IBDesignable
class ColorPickerView: UIView {
    
    @IBInspectable var color: UIColor!
    
    static var colorSpace = CGColorSpaceCreateDeviceRGB()
    
    override func draw(_ rect: CGRect) {
        ColorPickerView.drawGradient(for: self, with: rect)
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
    
    func getColor(for touch: UITouch) -> UIColor {
        let point = touch.location(in: self)
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let bitmapInfo = CGBitmapInfo(
            rawValue: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        let context = CGContext(
            data: pixel,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: ColorPickerView.colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )!
        context.translateBy(x: -point.x, y: -point.y)
        self.layer.render(in: context)
        let color = UIColor(
            red:   CGFloat(pixel[0]) / 255.0,
            green: CGFloat(pixel[1]) / 255.0,
            blue:  CGFloat(pixel[2]) / 255.0,
            alpha: CGFloat(pixel[3]) / 255.0
        )
        pixel.deallocate()
        return color
    }
    
    static func drawGradient(for view: UIView, with rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
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
            end: CGPoint(x: view.bounds.width, y: 0),
            options: []
        )
        context?.drawLinearGradient(
            whiteGradient,
            start: CGPoint.zero,
            end: CGPoint(x: 0, y: view.bounds.height),
            options: []
        )
    }
    
    
}
