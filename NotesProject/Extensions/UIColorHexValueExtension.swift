//
//  UIColorHexValueExtention.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 9/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

extension UIColor {
    public var hexValue: String {
        guard let components = self.cgColor.components else {
            return "#FFFFFF"
        }
        return String(
            format: "#%02X%02X%02X",
            Int(components[0] * 255.0),
            Int(components[1] * 255.0),
            Int(components[2] * 255.0)
        )
    }
}
