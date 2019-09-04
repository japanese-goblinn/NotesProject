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
    let selfDestructionDate: Date?
    
    init(title: String,
         content: String,
         date: Date?,
         uid: String = UUID().uuidString,
         color: UIColor = .white,
         priority: Priority = .general) {
        self.title = title
        self.content = content
        self.selfDestructionDate = date
        self.uid = uid
        self.color = color
        self.priority = priority
    }
    
}
