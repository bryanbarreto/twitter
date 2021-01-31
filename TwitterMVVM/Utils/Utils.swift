//
//  Utils.swift
//  TwitterMVVM
//
//  Created by Bryan Barreto on 30/01/21.
//

import UIKit

class Utils {
    
    static func inputContainerView(icon: String, textfield tf:UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = UIImage(systemName: icon)
        iv.tintColor = .white
        
        view.addSubview(iv)
        iv.setDimensions(width: 24, height: 24)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        
        view.addSubview(tf)
        tf.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 8, paddingRight: 8, height: 0.7)
        
        return view
    }
    
    static func buildTextField(placeholder ph: String, fontSize fs: CGFloat = 18) -> UITextField{
        let tf = UITextField()
        tf.placeholder = ph
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: fs, weight: .bold)
        tf.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        return tf
    }
    
    static func buildAttributedButton(partOne one: String, partTwo two: String, fontSice: CGFloat) -> UIButton{
        let btn = UIButton()
        btn.titleLabel?.textAlignment = .center
        let title = NSMutableAttributedString(string: one, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSice), NSAttributedString.Key.foregroundColor: UIColor.white])
        title.append(NSAttributedString(string: " " + two, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSice), NSAttributedString.Key.foregroundColor: UIColor.white]))
        btn.setAttributedTitle(title, for: .normal)
        
        return btn
    }
}
