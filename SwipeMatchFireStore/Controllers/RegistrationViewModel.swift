//
//  RegistrationViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/21/21.
//

import UIKit

class RegistrationViewModel {
    
    var image: UIImage? { didSet {imageObserver?(image)} }
    var isRegistering : Bool? { didSet { isRegisteringObserver?(isRegistering)} }
    var fullName: String? { didSet {checkForValidity()} }
    var email: String? { didSet {checkForValidity()} }
    var password: String? { didSet {checkForValidity()} }
    
    
    // Reactive Programming
    var isFormValidObserver: ((Bool) -> ())?
    var imageObserver: ((UIImage?) -> ())?
    var isRegisteringObserver: ((Bool?) -> ())?
    
    private func checkForValidity() {
        let isFormVaild = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        isFormValidObserver?(isFormVaild)
    }
}
