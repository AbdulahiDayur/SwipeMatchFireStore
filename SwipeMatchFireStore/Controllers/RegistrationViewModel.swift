//
//  RegistrationViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/21/21.
//

import UIKit

class RegistrationViewModel {
    
    var image: UIImage? {
        didSet {
            imageObserver?(image)
        }
    }
    
    var imageObserver: ((UIImage?) -> ())?
    
    var fullName: String? { didSet {checkForValidity()} }
    var email: String? { didSet {checkForValidity()} }
    var password: String? { didSet {checkForValidity()} }
    
    private func checkForValidity() {
        let isFormVaild = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        isFormValidObserver?(isFormVaild)
    }
    
    // Reactive Programming
    var isFormValidObserver: ((Bool) -> ())?
}
