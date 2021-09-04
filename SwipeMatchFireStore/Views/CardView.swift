//
//  CardView.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 8/24/21.
//

import UIKit

class CardView: UIView {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    // Configuration
    private let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    private func configure() {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
//        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)

        default:
            ()
        }
    }
    
    private func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    private func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let shouldDismiss = gesture.translation(in: nil).x > threshold
        let shouldDismissLeft = gesture.translation(in: nil).x < -threshold
        
    
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1, options: .curveEaseOut,
                       animations: {
                        if shouldDismiss {
                            self.layer.frame = CGRect(x: 600, y: 0, width: self.frame.width, height: self.frame.height)
                            
                        } else if shouldDismissLeft{
                            self.layer.frame = CGRect(x: -600, y: 0, width: self.frame.width, height: self.frame.height)
                            
                        } else {
                            self.transform = .identity
                        }
                        
                       }) {(_) in
                            self.transform = .identity
                            self.frame = CGRect(x: 0, y: 0,
                            width: self.superview!.frame.width,
                            height: self.superview!.frame.height)
                       }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
