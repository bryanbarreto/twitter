//
//  ProfileHeader.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 17/02/21.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    static let id = "profileCollectionHeader"
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func handleDismiss(){
        print("dismiss profile")
    }
    
}


