//
//  NotesViewController.swift
//  VK
//
//  Created by Elina on 02/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextViewDelegate {
    
    let newNoteText = "Новая запись..."
    let lightGreyColor: UIColor = UIColor.lightGray
    let whiteColor: UIColor = UIColor.white
    let blackColor: UIColor = UIColor.black
    
    var dataTransferDelegate: DataTransferProtocol?
    @IBOutlet weak var postTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        setupNavigationBar()

    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = whiteColor
    }
    
    func setupTextView() {
        postTextView.delegate = self
        postTextView.text = newNoteText
        postTextView.textColor = lightGreyColor
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        guard let text = postTextView.text,
            !text.isEmpty
            else { return }
        
        dataTransferDelegate?.didPressReturn(with: text)
        navigationController?.popToViewController(dataTransferDelegate as! UIViewController, animated: true)
    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if postTextView.textColor == lightGreyColor {
            postTextView.text = ""
            postTextView.textColor = blackColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if postTextView.text == "" {
            postTextView.text = newNoteText
            postTextView.textColor = lightGreyColor
        }
    }
}
