//
//  CaptionTextView.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 15/02/21.
//

import UIKit

class CaptionTextView: UITextView {
    
    // MARK: - Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "What's happening?"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
        
        self.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        self.backgroundColor = .clear
        self.font = UIFont.systemFont(ofSize: 16)
        self.isScrollEnabled = false
        self.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        self.addSubview(self.placeholderLabel)
        self.placeholderLabel.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 16)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    // MARK: - Selectors
    @objc private func handleTextChange(){
        self.placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}
