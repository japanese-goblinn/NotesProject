//
//  ColorDelegate.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 9/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

protocol Colorable: AnyObject {
    func passValue(of color: UIColor)
    func passValue(of coordinates: CGPoint, and brightness: Float)
}
