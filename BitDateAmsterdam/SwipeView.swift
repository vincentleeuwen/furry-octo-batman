//
//  SwipeView.swift
//  BitDateAmsterdam
//
//  Created by Vincent van Leeuwen on 08/05/15.
//  Copyright (c) 2015 Vincent van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
    private let card: CardView = CardView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    init() {
        super.init(frame: CGRectZero)
        initialize()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(card)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        
        func dragged(gestureRecognizer: UIPanGestureRecognizer!) {
            let distance = gestureRecognizer.translationInView(self)
            println("Distance x:\(distance.x) y: \(distance.y)")
        }
            
        card.setTranslatesAutoresizingMaskIntoConstraints(false)

        setConstraints()
    }
    
    private func setConstraints() {
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0))
    }
}