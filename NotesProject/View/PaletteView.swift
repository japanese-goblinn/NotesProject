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
            Color.drawGradient(for: self, with: rect)
        }
        if isChosen {
            drawFlag(rect)
        }
    }
    
    private func drawBorders() {
        self.layer.borderWidth = 2
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
}
