//
//  ViewController.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/29/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class AllNotesViewController: UIViewController {
    
    let notes: [Note] = [Note(title: "Some title", content: "Some content", date: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? NotesDetailViewController,
            segue.identifier == "showNote" {
                controller.title = "New Note"
        }
    }

}

extension AllNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].uid
        return cell
    }
    
}
