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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        
        case .changed:
            let translation = gesture.translation(in: nil)
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)

        case .ended:
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.1, options: .curveEaseOut,
                           animations: {self.transform = .identity})

        default:
            ()
        }
    }
    
}
