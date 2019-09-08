//
//  ColorPickerView.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit
import CoreGraphics


//TODO: Global refactor this class to be separate component
@IBDesignable
class ColorPickerView: UIView {
    
    static var colorSpace = CGColorSpaceCreateDeviceRGB()
    
    private var x: CGFloat = 0
    private var y: CGFloat = 0
    
    private var dimmingFloat: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var valueOfDimming: Float {
        set {
            dimmingFloat = CGFloat(newValue)
        }
        get {
            return Float(dimmingFloat)
        }
    }
    var pickerPosition: (CGFloat, CGFloat) {
        set {
            x = newValue.0
            y = newValue.1
            setNeedsDisplay()
        }
        get {
            return (x, y)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ColorPickerView.drawGradient(for: self, with: rect)
        addDimming(for: dimmingFloat)
        drawPicker(x: x, y: y)
        drawBorders()
    }
    
    private func drawPicker(x: CGFloat, y: CGFloat) {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: x, y: y),
            radius: 12,
            startAngle: 0,
            endAngle: 180,
            clockwise: true
        )
        path.lineWidth = 6
        UIColor.white.setStroke()
        path.stroke()
        
    }
    
    private func drawBorders() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func addDimming(for num: CGFloat) {
        let context = UIGraphicsGetCurrentContext()
        let colors = [
            UIColor(white: 0, alpha: 1 - num).cgColor,
            UIColor(white: 0, alpha: 1 - num).cgColor
        ]
        let color = CGGradient(
            colorsSpace: ColorPickerView.colorSpace,
            colors: colors as CFArray,
            locations: nil
        )!
        context?.drawLinearGradient(
            color,
            start: CGPoint.zero,
            end: CGPoint(x: 0, y: self.bounds.height),
            options: []
        )
    }
    
    func getColor(in point: CGPoint) -> UIColor {
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
            red: CGFloat(pixel[0]) / 255.0,
            green: CGFloat(pixel[1]) / 255.0,
            blue: CGFloat(pixel[2]) / 255.0,
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
