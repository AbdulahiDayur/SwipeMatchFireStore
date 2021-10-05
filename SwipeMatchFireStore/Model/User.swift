//
//  User.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/4/21.
//

import UIKit

struct User: ProducesCardViewModel {
    // Defining our properties for our model layer
    var name: String?
    var age: Int?
    var profession: String?
    var imageURL1: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
        // we'll initialize our user here
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        
        self.name = dictionary["fullName"] as? String ?? ""
        self.imageURL1 = dictionary["imageURL1"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        let ageString = age != nil ? "\(age!)" : "N\\A"
        attributedText.append(NSAttributedString(string: "  \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        let professionString = profession != nil ? profession! : "Not available"
        attributedText.append(NSAttributedString(string: "\n\(professionString)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: [imageURL1 ?? ""], attributedString: attributedText, textAlignment: .left)
    }
}

