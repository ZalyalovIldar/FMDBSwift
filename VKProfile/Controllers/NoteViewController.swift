//
//  NoteViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 02.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var createNewsDelegate: CreateNewsDelegate?
    let whatsNew = "Что у Вас нового?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.white
        navigationBar.createBorders(on: .bottom, marginX: 0)
        newsTextView.delegate = self
        doneButton.isEnabled = false
        initTextView()
    }
    
    private func initTextView() {
        newsTextView.text = whatsNew
        newsTextView.textColor = UIColor.lightGray
        
        newsTextView.becomeFirstResponder()
        
        newsTextView.selectedTextRange = newsTextView.textRange(from: newsTextView.beginningOfDocument, to: newsTextView.beginningOfDocument)
    }

    @IBAction func onCancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneClick(_ sender: Any) {
        guard let mainText = newsTextView.text else { return }
        let news = News(text: mainText, image: nil, likeCount: 0, commentCount: 0, respostCount: 0)
        createNewsDelegate?.createNews(from: news)
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - TextView methods
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text as NSString?
        if let updatedText = currentText?.replacingCharacters(in: range, with: text) {
            
            if updatedText.isEmpty {
                textView.text = whatsNew
                textView.textColor = UIColor.lightGray
                
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
                
                doneButton.isEnabled = false
                
                return false
            } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
                textView.text = nil
                textView.textColor = UIColor.black
                
                doneButton.isEnabled = true
            }
            
            return true
        }
        
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }

}
