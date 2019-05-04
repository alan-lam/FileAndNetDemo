//
//  TextViewController.swift
//  FilesAndNetDemo
//
//  Created by Alan Lam on 5/4/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit

enum TextViewMode {
    case File
    case Web
}

class TextViewController: UIViewController, UITextViewDelegate {

    var editingFile = false
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Remove the readme info
        myTextView.text = ""
        editingFile = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if editingFile {
            saveFile()
        }
    }
    
    func saveFile() {
        // Find the directory to store the file
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("notes.txt")
            do {
                try myTextView.text.write(to: fileURL, atomically: true, encoding: .utf8)
            }
            catch {
                myTextView.text = "Error saving file"
            }
        }
    }
    
    @IBOutlet weak var myTextView: UITextView!
    
    // The default readme file
    let readmeFile = "readme.txt"
    
    // Caller sets mode to display text file or webpage
    var textViewMode = TextViewMode.File
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if textViewMode == .File {
            displayFile()
        }
        else {
            displayWebPage()
        }
    }
    
    func displayFile() {
        // Set up the text view delegate
        myTextView.delegate = self
        
        myTextView.text = "Loading File..."
        
        // Load in the readme file
        let filename = readmeFile.components(separatedBy: ["."])[0]
        let ext = readmeFile.components(separatedBy: ["."])[1]
        let fileURL = Bundle.main.url(forResource: filename, withExtension: ext)
        
        do {
            myTextView.text = try String(contentsOf: fileURL!)
        }
        catch {
            myTextView.text = "Error loading file"
        }
    }
    
    func displayWebPage() {
        myTextView.text = "Loading Webpage..."
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
