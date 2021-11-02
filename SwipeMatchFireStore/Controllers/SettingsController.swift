//
//  SettingsController.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 10/13/21.
//

import UIKit

class CustomImagePickerController: UIImagePickerController {
    var imageButton: UIButton?
}

class SettingsController: UITableViewController {
    
    lazy var image1Button = createButton(selector: #selector(handleSelectedPhoto(button:)))
    lazy var image2Button = createButton(selector: #selector(handleSelectedPhoto(button:)))
    lazy var image3Button = createButton(selector: #selector(handleSelectedPhoto(button:)))
    
    func createButton(selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }
    
    @objc func handleSelectedPhoto(button: UIButton) {
        let imagePicker = CustomImagePickerController()
        // delegate is listening when you select a photo using UIImagePickerControllerDelegate
        imagePicker.delegate = self
        imagePicker.imageButton = button
        present(imagePicker, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationItems()
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.tableFooterView = UIView()
    }
    
    lazy var header: UIView = {
        let header = UIView()
        
        header.addSubview(image1Button)
        let padding: CGFloat = 16
        image1Button.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil,
                            padding: .init(top: padding, left: padding, bottom: padding, right: 0))
        image1Button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [image2Button, image3Button])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        
        header.addSubview(stackView)
        stackView.anchor(top: header.topAnchor, leading: image1Button.trailingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        return header
    }()
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {return header}
        let headerLabel = UILabel()
        headerLabel.text = "name"
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 300}
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        return cell
    }
    
    private func setUpNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(handelCancel))
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "Save",
                style: .plain,
                target: self,
                action: #selector(handelCancel)),
            
            UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(handelCancel))
        ]
    }
    
    @objc private func handelCancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedPhoto = info[.originalImage] as? UIImage
        
        // How do I set the image on my buttons when i select a photo?
        let imageButton = (picker as? CustomImagePickerController)?.imageButton
        imageButton?.setImage(selectedPhoto?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
