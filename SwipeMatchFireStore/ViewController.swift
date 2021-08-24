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
        
//        let grayView = UIView()
//        grayView.backgroundColor = .gray
        
        let subViews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            return view
        }
        
        let topStackView = UIStackView(arrangedSubviews: subViews)
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        
        let buttonStackView = HomeBottomControlsStackView()

        
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.fillSuperview()
        
    }


}

