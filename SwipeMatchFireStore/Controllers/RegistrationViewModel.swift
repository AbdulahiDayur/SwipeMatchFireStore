//
//  RegistrationViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/21/21.
//

import UIKit

class RegistrationViewModel {
    
    var fullName: String? {
        didSet {
            
        }
    }
    var email: String? { didSet {} }
    var password: String? { didSet {} }
    
    
    // Reactive Programming
    let isFormValidObserver: ((Bool) -> ()?)
}
