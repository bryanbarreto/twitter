//
//  Authentication.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 31/01/21.
//

import Foundation
import Firebase

class Authentication {
    
    static let shared = Authentication()
    private let authManager = Auth.auth()
    private let dbManager = Firestore.firestore()
    private let storageManager = Storage.storage().reference()
    
    func createUser(email: String, password: String, onSuccess: @escaping (_ uid: String) -> Void, onFail: @escaping (_ error: String) -> Void){
        self.authManager.createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result, error == nil else {
                onFail(error!.localizedDescription)
                return
            }
            
            let uid = result.user.uid
            onSuccess(uid)
        }
    }
    
    func uploadProfilePhoto(_ imageData:Data, name: String, onSuccess: @escaping (_ profileStringURL: String) -> Void, onFail: @escaping (_ error: String) -> Void){
        
        let storageRef = self.storageManager.child("profile_photo").child(name)
        
        storageRef.putData(imageData, metadata: nil) { (_, error) in
            guard error == nil else {
                onFail(error!.localizedDescription)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                guard let photoProfileStringURL = url?.absoluteString, error == nil else {
                    onFail(error!.localizedDescription)
                    return
                }
                
                onSuccess(photoProfileStringURL)
            }
        }
    }
    
    func saveAditionalUserData(_ userData: User, uid: String, onSuccess: @escaping () -> Void, onFail: @escaping (_ error: String) -> Void){
        
        guard let userDataFirebaseFormat = userData.firebaseFormat else {
            onFail("Erro ao transformar objeto swift para formato firebase")
            return
        }
        
        self.dbManager.collection("users").document(uid).setData(userDataFirebaseFormat) { (error) in
            guard error == nil else {
                onFail(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    func authenticateUser() -> Bool {
        return self.authManager.currentUser != nil
    }
    
    func logoutUser(success: @escaping () -> Void, fail: @escaping () -> Void){
        do{
            try self.authManager.signOut()
            success()
            return
        }catch{
            fail()
            return
        }
    }
    
    func login(email: String, password: String, completion: AuthDataResultCallback?){
        self.authManager.signIn(withEmail: email, password: password, completion: completion)
    }
    
    func getUserUID() -> String? {
        return self.authManager.currentUser?.uid
    }
}
