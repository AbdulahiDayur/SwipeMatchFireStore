//
//  User.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/4/21.
//

import UIKit

struct User: ProducesCardViewModel {
    // Defining our properties for our model layer
    let name: String
    let age: Int
    let profession: String
    let imageName: [String]
    
    init(dictionary: [String: Any]) {
        // we'll initialize our user here
        let name = dictionary["fullName"] as? String ?? ""
        self.name = name
        self.age = 0
        self.profession = "Jobless"
        
        let imageURL1 = dictionary["imageURL"] as? String ?? ""
        self.imageName = [imageURL1]
    }
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: imageName, attributedString: attributedText, textAlignment: .left)
    }
}

