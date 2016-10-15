//
//  CollegeViewController.swift
//  MakeSchoolNotes
//
//  Created by Liya Wu-17 on 8/9/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class CollegeViewController: UIViewController {
     var note: Note?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayCollege" {
                let displayNoteVC = segue.destinationViewController as! DisplayNoteViewController
                //destinationViewController --> get access to the Display Note View Controller
                
                displayNoteVC.note = note
                //setting the note property of the Display Note View Controller to the corresponding to the cell that the user tapped
            }
        }
    }

}
