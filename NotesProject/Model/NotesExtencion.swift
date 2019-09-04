//
//  NotesExtencion.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import UIKit

extension Note {
    
    var json: [String: Any] {
        
        var jsonObject = [String: Any]()
        
        jsonObject["uid"] = uid
        jsonObject["title"] = title
        jsonObject["content"] = content
        
        if color != .white {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
            jsonObject["color"] = [r, g, b, a]
        }
        
        if priority != .general {
            jsonObject["priority"] = priority.rawValue
        }
        
        if let date = selfDestructionDate {
            let dateToString = DateFormatter()
            dateToString.dateFormat = "yyyy-MM-dd HH:mm:ss"
            jsonObject["selfDestructionDate"] = dateToString.string(from: date)
        } else {
            jsonObject["selfDestructionDate"] = nil
        }
        
        return jsonObject
    }
    
    static func parse(json: [String: Any]) -> Note? {
        guard
            let uid = json["uid"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String else {
                return nil
        }
        
        var color: UIColor
        if let colorFromJSON = json["color"] as? [CGFloat] {
            color = UIColor(
                displayP3Red: colorFromJSON[0],
                green: colorFromJSON[1],
                blue: colorFromJSON[2],
                alpha: colorFromJSON[3]
            )
        } else {
            color = .white
        }
        
        var priority: Priority
        if let priorityFromJSON = json["priority"] as? String {
            priority = Priority(rawValue: priorityFromJSON)!
        } else {
            priority = .general
        }
        
        var date: Date?
        if let dateFromJSON = json["selfDestructionDate"] as? String {
            let convertFromJSON = DateFormatter()
            convertFromJSON.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = convertFromJSON.date(from: dateFromJSON)
        } else {
            date = nil
        }
        
        return Note(
            title: title,
            content: content,
            date: date,
            uid: uid,
            color: color,
            priority: priority
        )
    }
    
}
