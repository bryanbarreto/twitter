//
//  FeedController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var tweets:[Tweet] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var user: User? {
        didSet {
            self.configureLeftBarButton()
        }
    }
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureUI()
        self.fetchTweets()
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.cellID)
    }
    
    // MARK: - API
    func fetchTweets(){
        TweetService.shared.fetchTweets { (tweets) in
            self.tweets = tweets
        } onFail: { (error) in
            print(error.localizedDescription)
        }

    }
    
    
    // MARK: - Helper Functions
    private func configureUI(){
        let image = UIImage(systemName: Constants.Feed.navigationTitle)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.setDimensions(width: 44, height: 44)
        self.navigationItem.titleView = imageView
    }
    
    private func configureLeftBarButton(){
        guard let user = self.user else {return}
        guard let url = user.profileURL else {return}

        let profileImageView = UIImageView()
        let size: CGFloat = 32
        
        profileImageView.setDimensions(width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        profileImageView.layer.masksToBounds = true
        
//        profileImageView.sd_setImage(with: url)
        profileImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"), options: [], completed: nil)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
}



// MARK: - CollectionView
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.cellID, for: indexPath) as? TweetCell
        
        cell?.tweet = self.tweets[indexPath.row]
        cell?.delegate = self
        
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - FlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
}

// MARK: - TweetCell Delegate
extension FeedController: TweetCellDelegate {
    func didTappedProfileImageView() {
        let vc = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
