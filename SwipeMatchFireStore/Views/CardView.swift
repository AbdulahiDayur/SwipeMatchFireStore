//
//  CardView.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 8/24/21.
//

import UIKit

class CardView: UIView {
    
    //Property observer
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barStackView.addArrangedSubview(barView)
            }
            barStackView.arrangedSubviews.first?.backgroundColor = .white
        }
    }
    
    let imageView = UIImageView()
    let gradientLayer = CAGradientLayer()
    let informationLabel = UILabel()
    
    private let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    var imageIndex = 0
    let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true: false
        
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
//        if shouldAdvanceNextPhoto {
//            imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
//        } else {
//            imageIndex = max(0, imageIndex - 1)
//        }
//
//
//        let imageName = cardViewModel.imageNames[imageIndex]
//        imageView.image = UIImage(named: imageName)
//        barStackView.subviews.forEach { (view) in
//            view.backgroundColor = barDeselectedColor
//        }
//        barStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    
    private func setupLayout() {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupBarStackView()
    
        // add a gradient layer
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                                padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    
    let barStackView = UIStackView()
    
    func setupBarStackView() {
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                            padding: .init(top: 8, left: 8, bottom: 0, right: 8),
                            size: .init(width: 0, height: 4))
        
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
    }
    
    func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.8, 1]
        gradientLayer.frame = self.frame
        
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
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
        
        let shouldDismissRight = gesture.translation(in: nil).x > threshold
        let shouldDismissLeft = gesture.translation(in: nil).x < -threshold
        
    
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1, options: .curveEaseOut,
                       animations: {
                        if shouldDismissRight {
                            self.layer.frame = CGRect(x: 600, y: 0, width: self.frame.width, height: self.frame.height)
                            
                        } else if shouldDismissLeft{
                            self.layer.frame = CGRect(x: -600, y: 0, width: self.frame.width, height: self.frame.height)
                            
                        } else {
                            self.transform = .identity
                        }
                        
                       }) {(_) in
//                            self.transform = .identity
//                            self.frame = CGRect(x: 0, y: 0,
//                            width: self.superview!.frame.width,
//                            height: self.superview!.frame.height)
                       }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
