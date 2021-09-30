//
//  RegistrationController.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/18/21.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {
    
    // UI Components using closures
    let selectPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleSelectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter email"
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter Password"
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        return tf
    }()
    
    @objc func handleTextChange(textField: UITextField) {
        
        if textField == fullNameTextField {
            registrationViewModel.fullName = textField.text
        } else if textField == emailTextField {
            registrationViewModel.email = textField.text
        } else {
            registrationViewModel.password = textField.text
        }
    }
    
    let registerButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    let registerHud = JGProgressHUD(style: .dark)
    
    @objc func handleRegister() {
        print("REGISTER OUR USER IN FIREBASE AUTH")
        self.handleTapDismiss()
        
        // registering a brand new user
        registrationViewModel.performingRegistration { (err) in
            if let err = err {
                self.showHudWithError(error: err)
                return
            }
            print("FINISHED RGISTERING OUR USER")
        }
    }
    
    private func showHudWithError(error: Error) {
        registerHud.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        setupRegistrationViewModelObserver()
    }
    
    let registrationViewModel = RegistrationViewModel()
    
    private func setupRegistrationViewModelObserver() {
        
        registrationViewModel.bindableIsFormValid.bind { [weak self] (isFormValid) in
            guard let self = self else {return}
            guard let isFormValid = isFormValid else {return}

            self.registerButton.isEnabled = isFormValid
            if isFormValid == true {
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
            }
        }
        
        registrationViewModel.bindableImage.bind { [weak self] (image) in
            guard let self = self else {return}
            self.selectPhotoButton.setImage(image, for: .normal)
        }
//        registrationViewModel.imageObserver = { [weak self] (image) in
//            guard let self = self else {return}
//            self.selectPhotoButton.setImage(image, for: .normal)
//        }
        
        registrationViewModel.bindableIsRegistering.bind { [weak self] (isRegistering) in
            guard let self = self else {return}

            if isRegistering == true {
                self.registerHud.textLabel.text = "Register"
                self.registerHud.show(in: self.view)
            } else {
                self.registerHud.dismiss()
            }
        }
    }
    
    private func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc func handleTapDismiss(){
        self.view.endEditing(true) // Keyboard dismiss
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Detach yourself from Notification Center. You'll have a retain cycle. <--- BAD
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
        
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        
        // Figure out how tall keyboard actually is
        guard let value = notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        
        // Gap between register button and bottom of screen
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 12)
        
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 1, green: 0.2886515856, blue: 0.3460421562, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField ,passwordTextField, registerButton])

    
    private func setupLayout() {
        
//        let stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField ,passwordTextField, registerButton])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        registrationViewModel.bindableImage.value = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
}
