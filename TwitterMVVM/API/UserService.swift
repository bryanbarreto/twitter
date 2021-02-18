//
//  UserService.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 13/02/21.
//

import Foundation
import Firebase

class UserService {
    static let shared = UserService()
    private let dbManager = Firestore.firestore()
    
    func fetchUserInformation(uid: String, completion: @escaping (User) -> Void){
        self.dbManager.collection("users").document(uid).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else {return}
            
            let user = User(uid: uid, data: data)
            
            completion(user)
        }
    }
}
