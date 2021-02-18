//
//  TweetViewModel.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 17/02/21.
//

import UIKit

struct TweetViewModel {
    private let tweet: Tweet
    private let user: User
    
    init(with tweet: Tweet) {
        self.tweet = tweet
        self.user = self.tweet.user
    }
    
    private var attributedName: NSAttributedString {
        let name = NSAttributedString(string: self.user.name, attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        return name
    }
    
    private var attributedUsername: NSAttributedString {
        let username = NSAttributedString(string: " @\(self.user.username)", attributes: [.font:UIFont.systemFont(ofSize: 14), .foregroundColor:UIColor.lightGray])
        return username
    }
    
    private var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        
        let now = Date()
        
        return formatter.string(from: self.tweet.timestamp, to: now) ?? ""
    }
    
    private var atributedTimestamp: NSAttributedString {
        let attributedTimestamp = NSAttributedString(string: " - \(self.timestamp)", attributes: [.font:UIFont.systemFont(ofSize: 14), .foregroundColor:UIColor.lightGray ])
        return attributedTimestamp
    }
    
    var profileImageURL: URL? {
        return self.user.profileURL
    }
    
    var userInfoText: NSAttributedString {
        let userInfoText = NSMutableAttributedString(attributedString: self.attributedName)
        userInfoText.append(self.attributedUsername)
        userInfoText.append(self.atributedTimestamp)
        
        return userInfoText
    }
    
}
