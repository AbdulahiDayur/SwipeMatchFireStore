//
//  CardViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/7/21.
//

import UIKit


// Supports many different types of model objects (for cards)
// We'll define the properties that are view will display/render out
struct CardViewModel {
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}


