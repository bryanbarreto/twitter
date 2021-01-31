//
//  RegisterController.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class RegisterController: UIViewController {
    
    // MARK: - Properties
    var imagePickerController: UIImagePickerController!
    
    private let alreadyHaveAccountButton: UIButton = {
        let btn = Utils.buildAttributedButton(partOne: "Já tem uma conta?", partTwo: "Faça Login", fontSice: 18)
        btn.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return btn
    }()
    
    private let emailTtextfield: UITextField = {
        let tf = Utils.buildTextField(placeholder: "E-mail")
        return tf
    }()
    
    lazy var emailContentView: UIView = {
        let view = Utils.inputContainerView(icon: Constants.TextFields.email, textfield: self.emailTtextfield)
        return view
    }()
    
    private let senhaTextfield: UITextField = {
        let tf = Utils.buildTextField(placeholder: "Senha")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var senhaContentView: UIView = {
        let view = Utils.inputContainerView(icon: Constants.TextFields.password, textfield: self.senhaTextfield)
        return view
    }()
    
    private let nomeTextfield: UITextField = {
        let tf = Utils.buildTextField(placeholder: "Nome Completo")
        return tf
    }()
    
    lazy var nomeContentView: UIView = {
        let view = Utils.inputContainerView(icon: Constants.TextFields.fullName, textfield: self.nomeTextfield)
        return view
    }()
    
    private let usuarioTextfield: UITextField = {
        let tf = Utils.buildTextField(placeholder: "Usuário")
        return tf
    }()
    
    lazy var usuarioContentView: UIView = {
        let view = Utils.inputContainerView(icon: Constants.TextFields.username, textfield: self.usuarioTextfield)
        return view
    }()
    
    private let createAccountButton: UIButton = {
        let btn = Utils.buildAuthenticationButton(title: "Cadastrar")
        btn.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        return btn
    }()
    
    private let addPhotoButton: UIButton = {
        let btn = UIButton()
        btn.tintColor = .white
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(addProfilePhoto), for: .touchUpInside)
        btn.setBackgroundImage(UIImage(systemName: "camera"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageView?.clipsToBounds = true
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor.clear.cgColor
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
    
    @objc func createAccount(){
        print("creating account")
    }
    
    @objc func addProfilePhoto(){
        Utils.showImagePickerAlert(in: self) { [weak self] (sourceType) in
            self?.imagePickerController = UIImagePickerController()
            self?.imagePickerController.allowsEditing = true
            self?.imagePickerController.sourceType = sourceType
            self?.imagePickerController.delegate = self
            self?.present((self?.imagePickerController)!, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helper Functions
    private func configureUI(){
        self.view.backgroundColor = .twitterBlue
        
        self.view.addSubview(self.alreadyHaveAccountButton)
        self.alreadyHaveAccountButton.anchor(left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, height: 50)
        
        self.view.addSubview(self.addPhotoButton)
        self.addPhotoButton.setDimensions(width: 150, height: 150)
        self.addPhotoButton.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        
        let stack = UIStackView(arrangedSubviews: [emailContentView, senhaContentView, nomeContentView, usuarioContentView])
        stack.spacing = 20
        stack.axis = .vertical
        self.view.addSubview(stack)
        stack.anchor(top: self.addPhotoButton.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        self.view.addSubview(self.createAccountButton)
        self.createAccountButton.anchor(left: self.view.leftAnchor, bottom: self.alreadyHaveAccountButton.topAnchor, right: self.view.rightAnchor, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, height: 50)
    }
    
}

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("Erro ao recuperar foto escolhida pelo usuário")
            return
        }
        self.addPhotoButton.setImage(image, for: .normal)
        self.addPhotoButton.layer.borderColor = UIColor.white.cgColor
        self.addPhotoButton.layer.cornerRadius = self.addPhotoButton.frame.size.height / 2
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
