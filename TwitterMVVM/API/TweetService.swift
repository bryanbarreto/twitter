//
//  TweetService.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 15/02/21.
//

import Foundation
import Firebase

class TweetService {
    static let shared = TweetService()
    private let dbReference = Firestore.firestore()
    
    func uploadTweet(caption: String, completion: ((Error?) -> Void)?){
        guard let uid = Authentication.shared.getUserUID() else {return}
        
        let dateSince1970 = Date().timeIntervalSince1970
        
        let values: [String: Any] = [
            "uid":uid,
            "timestamp":Int(dateSince1970),
            "likes":0,
            "retweets":0,
            "caption":caption
        ]
        self.dbReference.collection("tweets").document().setData(values, completion: completion)
    }
    
    func fetchTweets(onSuccess: @escaping ([Tweet]) -> Void, onFail: @escaping (Error) -> Void){
        self.dbReference.collection("tweets").addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                onFail(error!)
                return
            }
            
            let documents = snapshot.documents
            
            var tweets: [Tweet] = []
            
            for tweet in documents {
                
                guard let uid = tweet["uid"] as? String else {return}
                
                let data = tweet.data()
                let tweetID = tweet.documentID
                
                UserService.shared.fetchUserInformation(uid: uid) { (user) in
                    let t = Tweet(user: user, tweetID: tweetID, data: data)
                    tweets.append(t)
                    
                    if tweet == documents.last {
                        let sortedTweets = tweets.sorted { (a, b) -> Bool in
                            a.timestamp > b.timestamp
                        }
                        onSuccess(sortedTweets)
                    }
                }
            }
        }
    }
}
