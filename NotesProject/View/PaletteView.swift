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
    @IBInspectable var isRoundedCorners: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isRoundedCorners {
            makeRoundedCorners()
        }
        if isGradient {
            ColorPickerView.drawGradient(for: self, with: rect)
        }
        if isChosen {
            drawFlag(rect)
        }
        drawBorders()
    }
    
    private func makeRoundedCorners() {
        clipsToBounds = true
        layer.cornerRadius = 11
    }
    
    private func drawBorders() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
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
}
