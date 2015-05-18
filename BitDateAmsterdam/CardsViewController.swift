//
//  CardsViewController.swift
//  BitDateAmsterdam
//
//  Created by Vincent van Leeuwen on 08/05/15.
//  Copyright (c) 2015 Vincent van Leeuwen. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, SwipeViewDelegate {
    
    struct Card {
        let cardView:CardView
        let swipeView:SwipeView
        let user:User
    }
    
    let frontCardTopMargin: CGFloat = 0
    let backCardTopMargin: CGFloat = 10
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: Card?
    var frontCard: Card?
    
    var users: [User]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
        navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardStackView.backgroundColor = UIColor.clearColor()
        
//        // Do any additional setup after loading the view, typically from a nib.
//        backCard = createCard(backCardTopMargin)
////        backCard!.delegate = self
//
//        
//        cardStackView.addSubview(backCard!.swipeView)
//        
////        frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
////        frontCard!.delegate = self
//        frontCard = createCard(frontCardTopMargin)
//        cardStackView.addSubview(frontCard!.swipeView)
        
        fetchUnviewedUsers({
            returnedUsers in
            self.users = returnedUsers
            println(self.users)
            
            if let card = self.popCard() {
                self.frontCard = card
                self.cardStackView.addSubview(self.frontCard!.swipeView)
            }
            if let card = self.popCard() {
                self.backCard = card
                self.backCard?.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
                self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
            }
        })
    }
    
    func goToProfile(button: UIBarButtonItem) {
        pageController.goToPreviousVC()
    }
    
    private func createCardFrame(topMargin: CGFloat)->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    
    private func createCard(user: User) -> Card {
        let cardView = CardView()
        cardView.name = user.name
        user.getPhoto({
            image in
            cardView.image = image
        })
        let swipeView = SwipeView(frame: createCardFrame(0))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView, user: user)
    }
    
    private func popCard() -> Card? {
        if users != nil && users?.count > 0 {
            return createCard(users!.removeLast())
        }
        return nil
    }
    
    private func switchCards() {
        // check if there is a back card, and if so promote it to front
        if let card = backCard {
            frontCard = card
            UIView.animateWithDuration(0.2, animations: {
                self.frontCard!.swipeView.frame = self.createCardFrame(self.frontCardTopMargin)
            })
        }
        // restack the back card
        if let card = self.popCard() {
            self.backCard = card
            self.backCard?.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
            self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
        }
    }
    
    // MARK: SwipeViewDelegate
    func swipedLeft() {
        println("Left!")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            switchCards()
        }
    }
    func swipedRight() {
        println("Right!")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            switchCards()
        }
    }
    
}