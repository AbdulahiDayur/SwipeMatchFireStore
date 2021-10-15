//
//  HomeBottomControlsStackView.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 8/23/21.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill // buttons might be stretched out, this helps.
        
        return button
    }
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))
    let dismissButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
    let superLikeButton = createButton(image: #imageLiteral(resourceName: "super_like_circle"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "like_circle"))
    let boostButton = createButton(image: #imageLiteral(resourceName: "boost_circle"))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        [refreshButton, dismissButton, superLikeButton, likeButton, boostButton].forEach { (UIButton) in
            self.addArrangedSubview(UIButton)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
