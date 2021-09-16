//
//  CardViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/7/21.
//

import UIKit


// Supports many different types of model objects (for cards)
// We'll define the properties that are view will display/render out

// View Model is supposed to represent the state of our View

protocol ProducesCardViewModel{
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    var imageIndex = 0
    
    func advanceToNextPhoto() {
        imageIndex = imageNames.count - 1
        
    }
    
    func goToPreviousPhoto() {
        imageIndex -= 1
    }
}


