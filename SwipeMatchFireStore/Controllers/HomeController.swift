//
//  HomeController.swift
//  SwipeMatchFireStore
//
//  Created by Abdul Dayur on 9/7/21.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomControls = HomeBottomControlsStackView()
    
    var cardViewModel = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        
        setupLayout()
        setupFirestoreUserCards()
        fetchUsersFromFireStore()
    }
    
    @objc func handleRefresh() {
        fetchUsersFromFireStore()
    }
    
    var lastFetchedUser: User?
    
    private func fetchUsersFromFireStore() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Fetching Users"
        hud.show(in: view)
        
        let query = Firestore.firestore().collection("users").order(by: "uid").start(at: [lastFetchedUser?.uid ?? ""]).limit(to: 2)
            
        query.getDocuments { (snapshot, err) in
            hud.dismiss()
            if let err = err {
                print("Failed to fetch users:", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapShot) in
                let userDictionary = documentSnapShot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModel.append(user.toCardViewModel())
                self.lastFetchedUser = user
                self.setupCardFromUser(user: user)
            })
        }
    }
    
    private func setupCardFromUser(user: User) {
        let cardView = CardView(frame: .zero)
        cardView.cardViewModel = user.toCardViewModel()
        cardsDeckView.addSubview(cardView)
        cardsDeckView.sendSubviewToBack(cardView)
        cardView.fillSuperview()
    }
    
    @objc func handleSettings() {
        let settingsController = SettingsController()
        let navController = UINavigationController(rootViewController: settingsController)
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
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
        let overallStackView  = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomControls])
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

