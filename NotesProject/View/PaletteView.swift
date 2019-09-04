//
//  PaletteView.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PaletteView: UIView {
    
    @IBInspectable var isChosen: Bool = false
    @IBInspectable var isGradient: Bool = false
    
    override func draw(_ rect: CGRect) {
        drawBorders()
        if isGradient {
            makeGradient(rect)
        }
        if isChosen {
            drawFlag(rect)
        }
    }
    
    private func drawBorders() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    private func drawFlag(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 8))
        path.addLine(to: CGPoint(x: rect.midX - 7, y: rect.midY - 2))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 8))
        path.addLine(to: CGPoint(x: rect.midX + 8, y: rect.midY - 8))
        if backgroundColor == UIColor.black {
            UIColor.white.setStroke()
        }
        path.stroke()
    }
    
    private func makeGradient(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        for y: CGFloat in stride(from: 0.0 ,to: rect.height, by: 1) {
            var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
            saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? 2.0 : 1.3))
            let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
            for x: CGFloat in stride(from: 0.0, to: rect.width, by: 1) {
                let hue = x / rect.width
                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                context!.setFillColor(color.cgColor)
                context!.fill(CGRect(x: x, y: y, width: 1, height: 1))
            }
        }
    }
}
