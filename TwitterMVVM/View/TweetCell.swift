//
//  TweetCell.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 15/02/21.
//

import UIKit

protocol TweetCellDelegate: class {
    func didTappedProfileImageView()
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellID = "tweetCell"
    
    weak var delegate: TweetCellDelegate?
    
    var tweet: Tweet? {
        didSet {
            self.configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        let size: CGFloat = 48
        iv.setDimensions(width: size, height: size)
        iv.layer.cornerRadius = size/2
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .twitterBlue
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "caption label"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "info Label"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var commentButton = self.buildTweetButton(image: UIImage(systemName: "bubble.right"), selector: #selector(commentButtonTapped))
    
    private lazy var retweetButton = self.buildTweetButton(image: UIImage(systemName: "arrow.rectanglepath"), selector: #selector(retweetButtonTapped))
    
    private lazy var likeButton = self.buildTweetButton(image: UIImage(systemName: "hand.thumbsup"), selector: #selector(likeButtonTapped))
    
    private lazy var shareButton = self.buildTweetButton(image: UIImage(systemName: "square.and.arrow.up"), selector: #selector(shareButtonTapped))
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(self.profileImageView)
        self.profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 12, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [self.infoLabel, self.captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4

                
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        self.addSubview(underlineView)
        underlineView.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, height: 1)
        
        self.addSubview(stack)
        stack.anchor(top: self.profileImageView.topAnchor, left: self.profileImageView.rightAnchor, right: self.rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        let actionButtonsStack = UIStackView(arrangedSubviews: [self.commentButton, self.retweetButton, self.likeButton, self.shareButton])
        actionButtonsStack.axis = .horizontal
        actionButtonsStack.alignment = .fill
        actionButtonsStack.distribution = .fillEqually
        actionButtonsStack.spacing = 20
        
        self.addSubview(actionButtonsStack)
        actionButtonsStack.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingLeft: 10, paddingBottom: 8, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func commentButtonTapped(){
        print("commentButtonTapped")
    }
    
    @objc private func likeButtonTapped(){
        print("likeButtonTapped")
    }
    
    @objc private func retweetButtonTapped(){
        print("retweetButtonTapped")
    }
    
    @objc private func shareButtonTapped(){
        print("shareButtonTapped")
    }
    
    @objc private func profileImageTapped(){
        self.delegate?.didTappedProfileImageView()
    }
    
    // MARK: - Helpers
    private func buildTweetButton(image: UIImage?, selector: Selector) -> UIButton{
        let button = UIButton()
        button.tintColor = .darkGray
        button.setImage(image, for: .normal)
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private func configure(){
        guard let tweet = self.tweet else {return}
        
        let tweetViewModel = TweetViewModel(with: tweet)
        
        self.infoLabel.attributedText = tweetViewModel.userInfoText
        self.profileImageView.sd_setImage(with: tweetViewModel.profileImageURL)
    }
    
}
