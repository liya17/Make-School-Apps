//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//


//Display Note View Controller is used to both create new notes and modify existing notes, we must check whether the note property is nil (which would indicate that we are creating a new note) or if it contains a value (which would indicate that we are modifying an existing note) to determine the appropriate action.

import UIKit
import RealmSwift


class DisplayNoteViewController: UIViewController {

    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var noteContentTextView: UITextView!
    
    
    var note: Note? //it could either contain a value (in the case where an existing note is being modified) or it could be nil (in the case where we are creating a new note).
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        if segue.identifier == "Save" {
            // if note exists, update title and content
            if let note = note {
                // 1
                let newNote = Note()
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                RealmHelper.updateNote(note, newNote: newNote)
            } else {
                // if note does not exist, create new note
                let note = Note()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = NSDate()
                // 2
                RealmHelper.addNote(note)
            }
            //Here we make sure that the ListNotesTableViewController is up to date with the changes we just made by retrieving all the notes from Realm and assigning them to the notes property.
            listNotesTableViewController.notes = RealmHelper.retrieveNotes()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // We are using the optional binding technique to unwrap the value in the note property and storing the actual value (if it exists) in a local variable named note.
        if let note = note {
            //This code will only execute if the note property was not nil. We are setting the text field and text view properties to the note's title and content, respectively.
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        }
        else {
            //This code is executed if the note property was nil. This happens if we are creating a new note, so we set the text field and text view to empty strings to ensure that our users can immediately begin typing their new note.
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }

}
