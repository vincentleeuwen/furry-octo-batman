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
    
    enum Direction {
        case None
        case Left
        case Right
    }
    
    weak var delegate: SwipeViewDelegate?
    
    var direction: Direction?
    
    let overlay:UIImageView = UIImageView()
    
//    private let card: CardView = CardView()
    
    
    // use innerview instead of cardview for better performance
    var innerView: UIView? {
        didSet {
            if let v = innerView {
//                self.addSubview(v)
                self.insertSubview(v, belowSubview: overlay)
                v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            }
        }
    }
    
    
    private var originalPoint: CGPoint?
    
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
//        self.addSubview(card)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        
//        card.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
//        card.setTranslatesAutoresizingMaskIntoConstraints(false)

//        setConstraints()
        
        overlay.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(overlay)
        

    }
    
    func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translationInView(self)
        println("Distance x:\(distance.x) y: \(distance.y)")
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            originalPoint = center
        case UIGestureRecognizerState.Changed:
            
            let rotationPercentage = min(distance.x / (self.superview!.frame.width/2),1)
            let rotationAngle = CGFloat(CGFloat(2*M_PI/16)*rotationPercentage)
            transform = CGAffineTransformMakeRotation(rotationAngle)
            
            // move the center of the view with the drag
            center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
            
            updateOverlay(distance.x)

        case UIGestureRecognizerState.Ended:
            
            if abs(distance.x) < frame.width/4 {
                self.resetViewPositionAndTransformations()
            } else {
                swipe(distance.x > 0 ? .Right : .Left)
            }
            
        default:
            println("Default trigger for gesturerecognizer switch")
            break
        }
    }
    
    func swipe(s:Direction) {
        
        if s == Direction.None {
            return
        }
        var parentWith = superview!.frame.size.width
        if s == Direction.Left {
            parentWith *= -1
        }

        UIView.animateWithDuration(0.2, animations: { self.center.x = self.frame.origin.x * parentWith }, completion: {
                success in
                if let d = self.delegate {
                    s == Direction.Right ? d.swipedRight() : d.swipedLeft()
                }
            })
    }
    
    private func updateOverlay(distance: CGFloat) {
        var newDirection: Direction
        newDirection = distance < 0 ? Direction.Left : Direction.Right
        
        // check if direction has changed
        if newDirection != direction {
            direction = newDirection
            // if so, update the overlay image based on the direction
            overlay.image = direction == .Right ? UIImage(named: "yeah-stamp") : UIImage(named: "nah-stamp")
        }
        overlay.alpha = abs(distance) / (superview!.frame.width / 2)
        
    }
    
    private func resetViewPositionAndTransformations() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0)
            
            self.overlay.alpha = 0
        })
        
    }
    
//    private func setConstraints() {
//        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0))
//    }
}


protocol SwipeViewDelegate: class {
    func swipedLeft()
    func swipedRight()
}


