//
//  CardView.swift
//  BitDateAmsterdam
//
//  Created by Vincent van Leeuwen on 08/05/15.
//  Copyright (c) 2015 Vincent van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
    
    // make sure instance exists so we don't need an optional
    private let imageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
    // override init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
//    override init() {
//        super.init()
//    }
    // Swift 1.2:
    
    init() {
        super.init(frame: CGRectZero)
        initialize()
    }
    
    
    
    private func initialize() {
        // set layout for imageview
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.backgroundColor = UIColor.redColor()
        // add imageview to cardview
        self.addSubview(imageView)
        
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(nameLabel)
        
        backgroundColor = UIColor.whiteColor()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
}