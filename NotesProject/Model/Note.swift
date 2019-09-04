//
//  Note.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import UIKit

enum Priority: String {
    case important
    case general
    case notImportant
}

struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let priority: Priority
    let date: Date?
    
    init(uid: String, title: String, content: String, date: Date?, color: UIColor = UIColor.white, priority: Priority = Priority.general) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.priority = priority
        self.date = date
    }
    
}
