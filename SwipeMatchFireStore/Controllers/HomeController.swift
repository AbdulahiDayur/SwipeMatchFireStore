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
    
    
    let cardViewModel: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageName: ["kelly1", "kelly2", "kelly3"]),
            User(name: "Jane", age: 18, profession: "Teacher", imageName: ["jane1", "jane2", "jane3"]),
            Advertiser(title: "Slide Out Menu", brandName: "Lets Build That APP", posterPhotoName: "slide_out_menu_poster")
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map {return $0.toCardViewModel()}
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
        fetchUsersFromFireStore()
    }
    
    private func fetchUsersFromFireStore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Faild to fetch users:", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapShot) in
                documentSnapShot.data()
            })
        }
    }
    
    @objc func handleSettings() {
        print("Show registration page")
        let registrationController = RegistrationController()
        registrationController.modalPresentationStyle = .fullScreen
        present(registrationController, animated: true)
    }
    
    private func setupDummyCards() {
        
        cardViewModel.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: cardVM.imageName)
//            cardView.informationLabel.attributedText = cardVM.attributedString
//            cardView.informationLabel.textAlignment = cardVM.textAlignment
            cardView.cardViewModel = cardVM
            
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

