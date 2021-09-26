//
//  RegistrationViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/21/21.
//

import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
    
    var fullName: String? { didSet {checkForValidity()} }
    var email: String? { didSet {checkForValidity()} }
    var password: String? { didSet {checkForValidity()} }
//    var image: UIImage? { didSet {imageObserver?(image)} }
    
    func performingRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else {return}
        
    }
    

//    Reactive Programming
//    var imageObserver: ((UIImage?) -> ())?
    
    private func checkForValidity() {
        let isFormVaild = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        bindableIsFormValid.value = isFormVaild
    }
}
