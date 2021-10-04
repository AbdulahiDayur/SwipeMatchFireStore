//
//  RegistrationViewModel.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/21/21.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
    
    var fullName: String? { didSet {checkForValidity()} }
    var email: String? { didSet {checkForValidity()} }
    var password: String? { didSet {checkForValidity()} }
//    var image: UIImage? { didSet {imageObserver?(image)} }
    
    // registering a brand new user
    // ----------------------- call completion if encounter error
    func performingRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else {return}
        self.bindableIsRegistering.value = true
        
        // registering a brand new user
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, err) in
            guard let self = self else {return}
            if let err = err {
                completion(err)
                return
            }
            
            print("SUCCESSFULLY REGISTERED USER:", result?.user.uid ?? "")
            self.saveImageToFireBase(completion: completion)
        }
    }
    
    func saveImageToFireBase(completion: @escaping (Error?) -> ()) {
        // upload images to firebase storage
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        
        ref.putData(imageData, metadata: nil) { (_, err) in
            
            if let err = err {
                completion(err)
                return
            }
            print("FINISHED UPLOADING IMAGE TO STORAGE")
            ref.downloadURL { (url, err) in
                if let err = err {
                    completion(err)
                    return
                }
                
                self.bindableIsRegistering.value = false
                print("DOWNLOAD URL OF OUR IMAGE IS: ", url?.absoluteString ?? "")
                
                let imageURL = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageURL: imageURL ,completion: completion)
            }
        }
    }
    
    private func saveInfoToFirestore(imageURL: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageURL1": imageURL]
        
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            
            completion(nil)
        }
    }
    
    
//    Reactive Programming
//    var imageObserver: ((UIImage?) -> ())?
    
    private func checkForValidity() {
        let isFormVaild = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        bindableIsFormValid.value = isFormVaild
    }
}
