//
//  User.swift
//  BitDateAmsterdam
//
//  Created by Vincent van Leeuwen on 15/05/15.
//  Copyright (c) 2015 Vincent van Leeuwen. All rights reserved.
//

import Foundation

struct User {
    let id:String
//    let pictureURL:String
    let name:String
    private let pfUser: PFUser
    
    func getPhoto(callback: (UIImage) -> ()) {
        let imageFile = pfUser.objectForKey("picture") as! PFFile
        
        imageFile.getDataInBackgroundWithBlock({
            data, error in
            if let data = data {
                callback(UIImage(data: data)!)
            }
            
            })
        
    }
}

private func pfUserToUser(user: PFUser) -> User {
    return User(id: user.objectId!, name: user.objectForKey("firstName") as! String, pfUser: user)
}

func currentUser() -> User? {
    if let user = PFUser.currentUser() {
        return pfUserToUser(user)
    }
    return nil
}

func saveSkip(user: User) {
    let skip = PFObject(className: "Action") // get_or_create a Parse column in code
    skip.setObject(PFUser.currentUser()!.objectId!, forKey: "byUser")
    skip.setObject(user.id, forKey: "toUser")
    skip.setObject("skipped", forKey: "type")
    skip.saveInBackgroundWithBlock(nil)
}

func saveLike(user: User) {
    let like = PFObject(className: "Action") // get_or_create a Parse column in code
    like.setObject(PFUser.currentUser()!.objectId!, forKey: "byUser")
    like.setObject(user.id, forKey: "toUser")
    like.setObject("liked", forKey: "type")
    like.saveInBackgroundWithBlock(nil)
}

func fetchUnviewedUsers(callback: ([User]) -> ()) {
    
    PFUser.query()!
        .whereKey("objectId", notEqualTo: PFUser.currentUser()!.objectId!)
        .findObjectsInBackgroundWithBlock({
            objects, error in
            if let pfUsers = objects as? [PFUser] {
                let users = map(pfUsers, {pfUserToUser($0)})
                callback(users)
            }
        }
    )


    
    
//    PFUser.query()
//        .whereKey("objectID", notEqualTo: PFUser.currentUser()?.objectId!)
//        .findObjectsInBackgroundWithBlock {
//            objects, error in
//            if let pfUsers = objects as? [PFUser] {
//                let users = map(pfUsers, {pfUserToUser($0)})
//                callback(users)
//            }
//    }
}