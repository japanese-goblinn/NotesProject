//
//  PassNoteDelegate.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 9/8/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import Foundation

protocol Noteable: AnyObject {
    func passNote(_ note: Note)
}
