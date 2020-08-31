//
//  ViewController.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/29/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let notebook = FileNotebook()
    var selectedNote: Note?
    
    private func addSomeNotes() {
        let notes = [
            Note(title: "Title", content: "Some content", date: nil),
            Note(title: "Like really deep", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", date: nil, uid: "some string", color: .yellow, priority: .important)
        ]
        for note in notes {
            notebook.add(note)
        }
    }
    
    @IBAction func addNote(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showNewNote", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeNotes()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let controller = segue.destination as? NotesDetailViewController,
            segue.identifier == "showNote" {
                controller.note = selectedNote
        }
        if let controller = segue.destination as? NotesDetailViewController,
            segue.identifier == "showNewNote" {
            controller.title = "New Note"
            controller.delegate = self
        }
    }

}

extension NotesTableViewController: Noteable {
    func passNote(_ note: Note) {
        notebook.add(note)
        tableView.reloadData()
    }
}

extension NotesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesTableViewCell
        let note = notebook.notes[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = note.title
        cell.contentLabel.text = note.content
        cell.colorView.backgroundColor = note.color
        return cell
    }

}

extension NotesTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectedNote = notebook.notes[indexPath.row]
    }
}
