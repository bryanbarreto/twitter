//
//  UserData.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 31/01/21.
//

import Foundation

struct User: Codable {
    var uid: String = ""
    let name: String
    let email: String
    let username: String
    var profileURL: URL?
    
    init(name: String, email: String, username: String, profileURL: String){
        self.name = name
        self.email = email
        self.username = username
        self.profileURL = URL(string: profileURL)
    }
    
    init(uid: String, data: [String: Any]){
        self.uid = uid
        self.name = data["name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        
        if let profileURLString = data["profileURL"] as? String {
            guard let url = URL(string: profileURLString) else {return}
            self.profileURL = url
        }
    }
}
