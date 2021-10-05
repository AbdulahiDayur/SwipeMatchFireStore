//
//  HomeController.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/7/21.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
    var cardViewModel = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupFirestoreUserCards()
        fetchUsersFromFireStore()
    }
    
    private func fetchUsersFromFireStore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users:", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapShot) in
                let userDictionary = documentSnapShot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModel.append(user.toCardViewModel())
            })
            self.setupFirestoreUserCards()
        }
    }
    
    @objc func handleSettings() {
        print("Show registration page")
        let registrationController = RegistrationController()
        registrationController.modalPresentationStyle = .fullScreen
        present(registrationController, animated: true)
    }
    
    private func setupFirestoreUserCards() {
        
        cardViewModel.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
        //  cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        let overallStackView  = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        
        overallStackView.anchor(top     : view.safeAreaLayoutGuide.topAnchor,
                                leading : view.leadingAnchor,
                                bottom  : view.safeAreaLayoutGuide.bottomAnchor,
                                trailing: view.trailingAnchor)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}

