//
//  CustomTextField.swift
//  TodoList
//
//  Created by aykut ipek on 9.02.2023.
//

import UIKit

class CustomTextField: UITextField{
    init(textField: String){
        super.init(frame: .zero)
        attributedPlaceholder = NSMutableAttributedString(string: textField, attributes: [.foregroundColor: UIColor.white])
        borderStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
