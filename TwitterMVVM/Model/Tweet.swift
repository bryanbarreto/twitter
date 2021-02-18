//
//  Tweet.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 15/02/21.
//

import Foundation

struct Tweet {
    
    let user: User
    
    let tweetID: String
    let caption: String
    let likes: Int
    let retweets: Int
    let uid: String
    var timestamp: Date
    
    init(user:User, tweetID: String, data: [String: Any]) {
        
        self.user = user
        
        self.tweetID = tweetID
        
        self.caption = data["caption"] as? String ?? ""
        self.likes = data["likes"] as? Int ?? 0
        self.retweets = data["retweets"] as? Int ?? 0
        self.uid = data["uid"] as? String ?? ""
        
        if let timeInterval = data["timestamp"] as? TimeInterval {
            let date = Date(timeIntervalSince1970: timeInterval)
            self.timestamp = date
        } else {
            self.timestamp = Date()
        }
    }
}
