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
        let cardView: CardView
        let swipeView: SwipeView
    }
    
    let frontCardTopMargin: CGFloat = 0
    let backCardTopMargin: CGFloat = 10
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: Card?
    var frontCard: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardStackView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view, typically from a nib.
        backCard = createCard(backCardTopMargin)
//        backCard!.delegate = self

        
        cardStackView.addSubview(backCard!.swipeView)
        
//        frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
//        frontCard!.delegate = self
        frontCard = createCard(frontCardTopMargin)
        cardStackView.addSubview(frontCard!.swipeView)
        
    }
    
    private func createCardFrame(topMargin: CGFloat)->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    
    private func createCard(topMargin: CGFloat) -> Card {
        let cardView = CardView()
        let swipeView = SwipeView(frame: createCardFrame(topMargin))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView)
    }
    
    // MARK: SwipeViewDelegate
    func swipedLeft() {
        println("Left!")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
        }
    }
    func swipedRight() {
        println("Right!")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
        }
    }
    
}