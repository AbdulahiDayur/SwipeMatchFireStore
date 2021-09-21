//
//  CustomTextField.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/20/21.
//

import UIKit

class CustomTextField: UITextField {
    
    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 25
    }
    
    // Assist with padding textfield
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adjusts height of textfield 
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    

}
