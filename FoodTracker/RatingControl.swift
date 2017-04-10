//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Taras on 10.03.17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
  
   //MARK: Properties
  private var ratingButtons = [UIButton]()
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }

  @IBInspectable var startSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }
  @IBInspectable var startCount: Int = 4 {
    didSet {
      setupButtons()
    }
  }
  
   //MARK: Private Methods
   private func setupButtons() {
    
   //Clear any existing buttons
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
   //Load Button Images
    let bundle = Bundle(for: type(of: self))
    let emptyHeart = UIImage(named: "emptyHeart", in: bundle, compatibleWith: self.traitCollection)
    let filledHeart = UIImage(named: "filledHeart", in: bundle, compatibleWith: self.traitCollection)
    let highlightedHeart = UIImage(named: "highlightedHeart", in: bundle, compatibleWith: self.traitCollection)
    
    for index in 0..<startCount {
  
   //Create the button
   let button = UIButton()
   //Set the button images
   button.setImage(emptyHeart, for: .normal)
   button.setImage(filledHeart, for: .selected)
   button.setImage(highlightedHeart, for: .highlighted)
   button.setImage(highlightedHeart, for: [.highlighted, .selected])
      
   //Set the accessibility label
      button.accessibilityLabel = "Set \(index + 1) star rating"
      
   //Button's constraints
   button.translatesAutoresizingMaskIntoConstraints = false
   button.heightAnchor.constraint(equalToConstant: startSize.height).isActive = true
   button.widthAnchor.constraint(equalToConstant: startSize.width).isActive = true
   //Setup the button action
    button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
    //Add the button to the stack
    addArrangedSubview(button)
    
    //Add the new button for the rating button array.
    ratingButtons.append(button)
    }
    updateButtonSelectionStates()
  }
   //MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }
  //MARK: Button's Actions
  func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.index(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }
    
    // Calculate the rating of the selected button
    let selectedRating = index + 1
    
    if selectedRating == rating {
      // If the selected star represents the current rating, reset the rating to 0.
      rating = 0
    } else {
      // Otherwise set the rating to the selected star
      rating = selectedRating
    
  }
}
  private func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
      //If the index of the button is less than the rating, that button should be selected.
      button.isSelected = rating > index
      //Set the hint string for the currently selected star.
      let hintString: String?
      if rating == index + 1 {
        hintString = "Tap to reset the rating to zero."
      } else {
        hintString = nil
      }
      //Calculate the value string
      let valueString: String?
      switch (rating) {
      case 0:
        valueString = "No rating yet."
      case 1:
        valueString = "1 star set."
      default:
        valueString = "\(rating) stars set."
      }
      //Assign the hint string and value string.
      button.accessibilityHint = hintString
      button.accessibilityValue = valueString
      }
    }
  }
