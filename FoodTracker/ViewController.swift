//
//  ViewController.swift
//  FoodTracker
//
//  Created by Taras on 27.02.17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  //MARK: Properties.
  @IBOutlet weak var nameTextField: UITextField!

  @IBOutlet weak var mealNameLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
  
  //Handle the text field’s user input through delegate callbacks.
  //The self refers to the ViewController class, because it’s referenced inside the scope of the ViewController class definition.
    nameTextField.delegate = self
   }
  //MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  //Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    mealNameLabel.text = textField.text
  }
  //MARK: Actions.
  @IBAction func setDefaultLabelText(_ sender: Any) {
    mealNameLabel.text = "Default text"
    
  }
  
}

