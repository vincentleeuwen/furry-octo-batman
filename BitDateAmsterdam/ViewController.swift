//
//  ViewController.swift
//  BitDateAmsterdam
//
//  Created by Vincent van Leeuwen on 08/05/15.
//  Copyright (c) 2015 Vincent van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource {

    let cardsVC:UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as! UIViewController
    let profileVC:UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileNavController") as! UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        self.view.addSubview(CardView(frame: CGRect(x: 20.0, y: 20.0, width: 120.0, height: 200.0)))
        view.backgroundColor = UIColor.whiteColor()
        self.dataSource = self
        self.setViewControllers([cardsVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: PageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case cardsVC:
            return profileVC
        case profileVC:
            return nil
        default:
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        switch viewController {
        case cardsVC:
            return nil
        case profileVC:
            return cardsVC
        default:
            return nil  
        }
    }

}

