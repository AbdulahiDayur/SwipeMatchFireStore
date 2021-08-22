//
//  ViewController.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 8/21/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redView = UIView()
        redView.backgroundColor = .red
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [redView, blueView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.frame = .init(x: 50, y: 90, width: 300, height: 200)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }


}

