//
//  FeedController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class FeedController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureUI()
    }
    
    
    // MARK: - Helper Functions
    private func configureUI(){
        let image = UIImage(systemName: Constants.Feed.navigationTitle)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = imageView
    }
    
}
