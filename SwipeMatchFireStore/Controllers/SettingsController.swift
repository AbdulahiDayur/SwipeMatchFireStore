//
//  SettingsController.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 10/13/21.
//

import UIKit

class SettingsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
