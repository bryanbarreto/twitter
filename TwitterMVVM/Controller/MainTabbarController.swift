//
//  MainTabbarController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            guard let nav = self.viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        }
    }
    
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
    
    
    // MARK: - Selectors
    @objc private func floatActionButtonTapped(){
        guard let user = user else {return}
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchUserInformation(){
        guard let uid = Authentication.shared.getUserUID() else {return}
        UserService.shared.fetchUserInformation(uid: uid) { (user) in
            self.user = user
        }
    }
    
    func authenticateUser(){
//
//        Authentication.shared.logoutUser {
//
//        } fail: {
//
//        }
//
//
        if !Authentication.shared.authenticateUser() {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(nav, animated: false, completion: nil)
            }
            return
        }
        
        self.configureTabbar()
        self.configureViewControllers()
        self.configureUI()
        self.fetchUserInformation()
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.authenticateUser()
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
        let feedNav = self.buildNavigationController(rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()), tabbarItemImage: Constants.Feed.tabbarImage, selectedImage: Constants.Feed.tabbarSelectedImage, title: Constants.Feed.tabbarTitle)
        
        let exploreNav = self.buildNavigationController(rootViewController: ExploreController(), tabbarItemImage: Constants.Explore.tabbarImage, selectedImage: Constants.Explore.tabbarSelectedImage, title: Constants.Explore.tabbarTitle)
        
        let notificationNav = self.buildNavigationController(rootViewController: NotificationController(), tabbarItemImage: Constants.Notification.tabbarImage, selectedImage: Constants.Notification.tabbarSelectedImage, title: Constants.Notification.tabbarTitle)
        
        let conversationNav = self.buildNavigationController(rootViewController: ConversationController(), tabbarItemImage: Constants.Conversation.tabbarImage, selectedImage: Constants.Conversation.tabbarSelectedImage, title: Constants.Conversation.tabbarTitle)
        
        
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
}

extension MainTabbarController: LoginControllerDelegate {
    func loginSuccess() {
        self.authenticateUser()
    }
}
