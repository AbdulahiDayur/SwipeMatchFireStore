//
//  CardView.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 8/24/21.
//

import UIKit

class CardView: UIView {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom drawing code
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
