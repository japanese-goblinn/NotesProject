//
//  FileNotebook.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation
import UIKit

class FileNotebook {
    private(set) var notes: [Note]
    
    public func add(_ note: Note) {
        if notes.isEmpty {
            notes.append(note)
        } else {
            for loopNote in notes {
                if loopNote.uid == note.uid {
                    return
                }
            }
            notes.append(note)
        }
    }
    
    public func remove(with uid: String) {
        if !notes.isEmpty {
            for (i, note) in notes.enumerated() {
                if note.uid == uid {
                    self.notes.remove(at: i)
                }
            }
        }
    }
    
    public func saveToFile() {
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        var isDir: ObjCBool = false
        let dirUrl = path.appendingPathComponent("caches")
        if FileManager.default.fileExists(atPath: dirUrl.path, isDirectory: &isDir), isDir.boolValue {
            let fileName = "notes.json"
            let fileURL = dirUrl.appendingPathComponent(fileName)
            let preparedArray = notes.map { $0.json }
            do {
                let content = try JSONSerialization.data(withJSONObject: preparedArray, options: [])
                try content.write(to: fileURL)
            } catch {
                print(error)
            }
        }
        else {
            try? FileManager.default.createDirectory(
                at: dirUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
            print("creating directory...")
        }
    }
    
    public func loadFromFile() {
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        var isDir: ObjCBool = false
        let dirUrl = path.appendingPathComponent("caches")
        if FileManager.default.fileExists(atPath: dirUrl.path, isDirectory: &isDir), isDir.boolValue {
            let fileName = "notes.json"
            let fileURL = dirUrl.appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: fileURL)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let notesFromJSON = json as? [[String: Any]] {
                    for note in notesFromJSON {
                        if let currentNote = Note.parse(json: note) {
                            notes.append(currentNote)
                        }
                    }
                }
            } catch {
                print(error)
            }
        } else {
            print("please, save data first")
        }
    }
    
    init() {
        notes = [Note]()
    }
}
