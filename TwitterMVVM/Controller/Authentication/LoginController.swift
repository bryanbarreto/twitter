//
//  LoginController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

protocol LoginControllerDelegate {
    func loginSuccess()
}

class LoginController: UIViewController {
    
    
    // MARK: - Properties
    var delegate: LoginControllerDelegate?
    
    var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: Constants.Login.logoImage)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.tintColor = .red
        return iv
    }()
    
    lazy var emailContainerView: UIView = {
        let view = Utils.inputContainerView(icon: Constants.TextFields.email, textfield: self.emailTextField)
        return view
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = Utils.inputContainerView(icon: Constants.TextFields.email, textfield: self.passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utils.buildTextField(placeholder: "E-mail", keyboardType: .emailAddress, capitalization: .none)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utils.buildTextField(placeholder: "Senha", capitalization: .none)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = Utils.buildAuthenticationButton(title: "Login")
        btn.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        return btn
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let btn = Utils.buildAttributedButton(partOne: "Não tem conta?", partTwo: "Cadastre- se", fontSice: 18)
        btn.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureUI()
    }
    
    
    // MARK: - Selectors
    @objc func tappedLogin(){
        guard let email = self.emailTextField.text, !email.isEmpty,
              let password = self.passwordTextField.text, !password.isEmpty else {
                print("preencha os campos")
                return
              }
        
        Authentication.shared.login(email: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: " + error.localizedDescription)
            }
            
//            Em caso de sucesso, chama a função do delegate (MainTabbarController)
            self.delegate?.loginSuccess()
            self.dismiss(animated: true)
        }
    }
    
    @objc func goToRegister(){
        let controller = RegisterController()
        controller.delegate = self.delegate
        self.navigationController?.pushViewController(controller, animated: true)
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
        
        self.view.addSubview(self.dontHaveAccountButton)
        self.dontHaveAccountButton.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, height: 50)
        
        self.view.addSubview(self.loginButton)
        self.loginButton.anchor(left: self.view.leftAnchor, bottom: self.dontHaveAccountButton.topAnchor, right: self.view.rightAnchor, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, height: 50)
        
    }
    
}
