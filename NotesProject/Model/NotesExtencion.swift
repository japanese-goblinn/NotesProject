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
        if self.color == UIColor.white {
            return jsonObject
        }
        if self.priority == Priority.general {
            return jsonObject
        }
        jsonObject["uid"] = self.uid
        jsonObject["title"] = self.title
        jsonObject["content"] = self.content
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.color.getRed(&r, green: &g, blue: &b, alpha: &a)
        jsonObject["color"] = [r, g, b, a]
        jsonObject["priority"] = self.priority.rawValue
        if let dateToSave = self.date {
            let dateToString = DateFormatter()
            dateToString.dateFormat = "yyyy-MM-dd HH:mm:ss"
            jsonObject["date"] = dateToString.string(from: dateToSave)
        } else {
            jsonObject["date"] = nil
        }
        return jsonObject
    }
    
    static func parse(json: [String: Any]) -> Note? {
        guard let uid = json["uid"] as? String else {
            return nil
        }
        guard let title = json["title"] as? String else {
            return nil
        }
        guard let content = json["content"] as? String else {
            return nil
        }
        guard let colorFromJSON = json["color"] as? [CGFloat] else {
            return nil
        }
        let color = UIColor(
            displayP3Red: colorFromJSON[0],
            green: colorFromJSON[1],
            blue: colorFromJSON[2],
            alpha: colorFromJSON[3]
        )
        guard let priority = Priority(rawValue: json["priority"] as! String) else {
            return nil
        }
        let dateFromJSON = json["date"] as! String
        let convertFromJSON = DateFormatter()
        convertFromJSON.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = convertFromJSON.date(from: dateFromJSON)
        return Note(title: title,
                    content: content,
                    date: date,
                    uid: uid,
                    color: color,
                    priority: priority
        )
    }
    
}
