//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved
//

import RealmSwift
import UIKit

class ListNotesTableViewController: UITableViewController {

    var notes: Results<Note>! {
        didSet {
            tableView.reloadData() //tells the table view to reload all of its data whenever our notes property is changed
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    notes = RealmHelper.retrieveNotes() //wants to update the notes property every time the ListNotesViewController is loaded
  }
    
    // 1
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        // 1
        let row = indexPath.row
        
        // 2
        let note = notes[row]
        
        // 3
        cell.noteTitle.text = note.title
        
        // 4
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayCollege" {
                let indexPath = tableView.indexPathForSelectedRow! //uniquely identify each cell only using the row property of its corresponding index path --> use indexPath.row to retrieve the notes from the ntoes array that corresponds to the touched cell
                let note = notes[indexPath.row]
                let displayCollegeVC = segue.destinationViewController as! CollegeViewController
                //destinationViewController --> get access to the Display Note View Controller

                displayCollegeVC.note = note
                //setting the note property of the Display Note View Controller to the corresponding to the cell that the user tapped
            }
        }
    }
//        if let identifier = segue.identifier {
//            if identifier == "displayCollege" {
//                
//            
//                
//                if identifier == "displayNote" {
//                    print("Table view cell tapped")
//                    
//                    let indexPath = tableView.indexPathForSelectedRow! //uniquely identify each cell only using the row property of its corresponding index path --> use indexPath.row to retrieve the notes from the ntoes array that corresponds to the touched cell
//                    let note = notes[indexPath.row]
//                    let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
//                    //destinationViewController --> get access to the Display Note View Controller
//                    
//                    displayNoteViewController.note = note
//                    //setting the note property of the Display Note View Controller to the corresponding to the cell that the user tapped
//                    
//                } else if identifier == "addNote" {
//                    print("+ button tapped")
//                }
//            }
//        }
    }
    
    //By implementing tableView(_:commitEditingStyle:forRowAtIndexPath:), we enable the the table view to have additional editing modes, one of which is that the cells display the delete option when a user swipes right. The other mode is an insert mode, but that won't appear without additional configuration.
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//        {
//            if editingStyle == .Delete {
//            //Here we delete the note from Realm using the helper method we defined earlier. Notice how we can index in to the notes object the same way we could before, despite it being a Results<Note> now instead of a [Note]. Also like before, we use the indexPath.row to index into notes to delete the correct one.
//                RealmHelper.deleteNote(notes[indexPath.row])
//            //Here we update the notes property to reflect the changes.
//                notes = RealmHelper.retrieveNotes()
//        }
//    }

//    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
//        
//        // for now, simply defining the method is sufficient.
//        // we'll add code later
//        
//    }

