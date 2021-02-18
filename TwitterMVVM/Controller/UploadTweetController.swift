//
//  UploadTweetController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 15/02/21.
//

import UIKit

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    private let user: User
    
    private let captionTextView = CaptionTextView()
    
    private lazy var tweetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .twitterBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleTweet), for: .touchUpInside)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32/2
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        let size: CGFloat = 48
        
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: size, height: size)
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = size/2
        iv.backgroundColor = .twitterBlue
        
        return iv
    }()
    
    // MARK: - Selectors
    @objc private func dismissTweetScreen(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleTweet(){
        guard let caption = self.captionTextView.text, !caption.isEmpty else {return}
        
        TweetService.shared.uploadTweet(caption: caption) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Life cycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        
        print(self.user)
    }
    
    // MARK: - Helpers
    
    private func configureUI(){
        self.view.backgroundColor = .white
        self.title = "New Tweet"
        
        self.configNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [self.profileImageView, self.captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        self.view.addSubview(stack)
        stack.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, right: self.view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        self.profileImageView.sd_setImage(with: self.user.profileURL, completed: nil)
    }
    
    private func configNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        
        let leftBarButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(dismissTweetScreen))
        let rightBarButton = UIBarButtonItem(customView: self.tweetButton)
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}
