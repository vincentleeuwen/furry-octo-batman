//
//  LoginViewController.swift
//  BitDateAmsterdam
//
//  Created by Vincent van Leeuwen on 15/05/15.
//  Copyright (c) 2015 Vincent van Leeuwen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFBLogin(sender: UIButton) {
            PFFacebookUtils.logInWithPermissions(["public_profile", "user_about_me", "user_birthday"], block: { user, error in
                if user == nil {
                    println("Uh oh. FB login cancelled by user")
                    // add UIAlertcontroller before pushing to app store
                    return
                } else if user!.isNew {
                    println("User signed up through facebook")
                    
                    // make FB connection to request user data
                    FBRequestConnection.startWithGraphPath("/me?fields=picture,first_name,birthday,gender", completionHandler: { connection, result, error in
                            var r = result as! NSDictionary
//                            println(result)
                            user!["firstName"] = result["first_name"]
                            user!["gender"] = result["gender"]
                            user!["picture"] = ((r["picture"] as! NSDictionary)["data"] as! NSDictionary) ["url"]
                            var dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy"
                            user!["birthDay"] = dateFormatter.dateFromString(r["birthday"] as! String)
                            println(user)
                        user!.saveInBackgroundWithBlock({
                            success, error in
                            println(success)
                            println(error)
                        })
                    })
                } else {
                    println("User logged in through facebook.")
                }
                // direct to navigation controller here
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as? UIViewController
                self.presentViewController(vc!, animated: true, completion: nil)
            })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
