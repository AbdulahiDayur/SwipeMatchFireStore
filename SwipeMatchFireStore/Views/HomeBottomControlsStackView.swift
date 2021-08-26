//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 8/23/21.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
       // bottom row of buttons
       let subViews = [UIImage(imageLiteralResourceName: "refresh_circle"), UIImage(named: "dismiss_circle"),
        UIImage(named: "super_like_circle"),UIImage(named: "like_circle"),UIImage(named: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        for button in subViews {
            addArrangedSubview(button)
        }
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
