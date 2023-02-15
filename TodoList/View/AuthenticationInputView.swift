//
//  CustomTextField.swift
//  TodoList
//
//  Created by aykut ipek on 9.02.2023.
//

import UIKit


class AuthenticationInputView: UIView{
    init(image: UIImage, textField: UITextField){
        super.init(frame: .zero)
        backgroundColor = .clear
        //Image View
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        //Text Field
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        //Divider
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .white
        addSubview(divider)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 26),
            imageView.widthAnchor.constraint(equalToConstant: 26),
            
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.7)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
