//
//  ViewController.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/29/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class NotesTableViewController: UIViewController {

    let tableView = UITableView()
    
    let notebook = FileNotebook()
    var selectedNote: Note?
    
    private func addSomeNotes() {
        let notes = [
            Note(title: "Title", content: "Some content", date: nil, color: .red),
            Note(title: "Like really deep and more deep and deep and deep", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", date: nil, uid: "some string", color: .yellow, priority: .important)
        ]
        for note in notes {
            notebook.add(note)
        }
    }
    
    @IBAction func addNote(sender: UIBarButtonItem) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(
            NotesTableViewCell.self,
            forCellReuseIdentifier: String(describing: NotesTableViewCell.self)
        )
        tableView.tableFooterView = UIView()
        addSomeNotes()
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: NotesTableViewCell.self),
            for: indexPath
        ) as! NotesTableViewCell
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
