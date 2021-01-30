//
//  MainTabbarController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    // MARK: - Properties
    let FloatingActionButton:UIButton = {
        let btn = UIButton()
        btn.frame.size.height = 56
        btn.frame.size.width = 56
        btn.setImage(UIImage(systemName: "doc.fill.badge.plus"), for: .normal)
        btn.backgroundColor = .twitterBlue
        btn.tintColor = .white
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(floatActionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureTabbar()
        self.configureViewControllers()
        self.configureUI()
    }
    
    
    // MARK: - Helper Functions
    private func configureTabbar(){
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .label
    }
    
    private func configureUI(){
        self.view.addSubview(self.FloatingActionButton)
        self.FloatingActionButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        self.FloatingActionButton.layer.cornerRadius = self.FloatingActionButton.frame.size.height/2
    }
    
    private func configureViewControllers(){
        let feedNav = self.buildNavigationController(rootViewController: FeedController(), tabbarItemImage: "house", selectedImage: "house.fill", title: "Feed")
        let exploreNav = self.buildNavigationController(rootViewController: ExploreController(), tabbarItemImage: "magnifyingglass.circle", selectedImage: "magnifyingglass.circle.fill", title: "Explore")
        let notificationNav = self.buildNavigationController(rootViewController: NotificationController(), tabbarItemImage: "heart", selectedImage: "heart.fill", title: "Notification")
        let conversationNav = self.buildNavigationController(rootViewController: ConversationController(), tabbarItemImage: "envelope", selectedImage: "envelope.fill", title: "Conversation")
        
        self.viewControllers = [feedNav, exploreNav, notificationNav, conversationNav]
    }
    
    private func buildNavigationController(rootViewController: UIViewController, tabbarItemImage: String, selectedImage: String? = nil, title: String) -> UINavigationController {
        let vc = rootViewController
        vc.view.backgroundColor = .white
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = UIImage(systemName: tabbarItemImage)
        nav.tabBarItem.selectedImage = UIImage(systemName: selectedImage ?? tabbarItemImage)
        nav.tabBarItem.title = title
        nav.navigationBar.isTranslucent = false
        
        return nav
    }
    
    @objc private func floatActionButtonTapped(){
        
    }
    
}
