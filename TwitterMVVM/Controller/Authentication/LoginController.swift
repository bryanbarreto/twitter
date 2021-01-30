//
//  LoginController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class LoginController: UIViewController {
    
    
    // MARK: - Properties
    var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: Constants.Login.logoImage)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.tintColor = .red
        return iv
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.backgroundColor = .red
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: Constants.TextFields.email)

        view.addSubview(iv)

        iv.anchor(left: view.leftAnchor , bottom: view.bottomAnchor , paddingLeft:8 , paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        return view
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.backgroundColor = .green
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: Constants.TextFields.password)
        
        view.addSubview(iv)
        
        iv.anchor(left: view.leftAnchor , bottom: view.bottomAnchor , paddingLeft:8 , paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        return view
    }()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureUI()
    }
    
    
    // MARK: - Helper Functions
    private func configureUI(){
        self.view.backgroundColor = .twitterBlue
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
        
        self.view.addSubview(self.logoImageView)
        
        self.logoImageView.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        self.logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.spacing = 20
        stack.axis = .vertical
        
        self.view.addSubview(stack)
        
        stack.anchor(top: self.logoImageView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
    }
    
}
