//
//  RegisterController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class RegisterController: UIViewController {
    
    // MARK: - Properties
    private let alreadyHaveAccountButton: UIButton = {
        let btn = Utils.buildAttributedButton(partOne: "Já tem uma conta?", partTwo: "Faça Login", fontSice: 18)
        btn.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureUI()
    }
    
    // MARK: - Selectors
    @objc func goToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helper Functions
    private func configureUI(){
        self.view.backgroundColor = .twitterBlue
        
        self.view.addSubview(self.alreadyHaveAccountButton)
        self.alreadyHaveAccountButton.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, height: 50)
    }
    
}
