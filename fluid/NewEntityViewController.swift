//
//  NewEntityViewController.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/8/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit

class NewEntityViewController: UIViewController {

    // -MARK:- Attributes
    //NavigationBarController Reference
    var navBarController: NavBarController!
    
    var currentMode: EntityType!
    var currentSaveImage: UIImage!
    //-MARK: IBOutlets
    @IBOutlet weak var textView: UITextView!
    
    //-MARK: Top Bari
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func save(_ sender: UIButton) {
        navBarController.addEntity(mode: currentMode,value: textView.text);
        performSegue(withIdentifier: "UnwindAddingSegue", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarController.setNavigationBarHidden(true, animated: true)
        switch(currentMode!){
        case .task:
            backButton.setImage(UIImage(named: "backlamony"), for: .normal)
            label.text! = "New Task"
            label.textColor = UIColor(named:"LamonyKamony")
            currentSaveImage = UIImage(named:"savelamony")
            textView.placeholder = "What do you want to do?"
            break
        case .note:
            backButton.setImage(UIImage(named: "backwhite"), for: .normal)
            label.text! = "New Note"
            label.textColor = UIColor.white
            currentSaveImage = UIImage(named:"savewhite")
            textView.placeholder = "What do you want to remember?"
            break
        case .event:
            backButton.setImage(UIImage(named: "backtrkwaz"), for: .normal)
            label.text! = "New Event"
            label.textColor = UIColor(named:"trkwaz")
            currentSaveImage = UIImage(named:"savetrkwaz")
            textView.placeholder = "What is happening today?"

            break
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navBarController.setNavigationBarHidden(false, animated: true)
    }
}


extension NewEntityViewController: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = textView.text!.count > 0
        }
        if textView.text.count == 0 {
            saveButton.setImage(UIImage(named:"savedisabled"), for: .normal)
            saveButton.isEnabled = false
        }
        else {
            saveButton.setImage(currentSaveImage, for: .normal)
            saveButton.isEnabled = true

        }
    }
}
