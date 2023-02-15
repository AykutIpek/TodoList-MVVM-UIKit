//
//  RegisterViewModel.swift
//  TodoList
//
//  Created by aykut ipek on 10.02.2023.
//

import Foundation

struct RegisterViewModel{
    var emailText: String?
    var nameText: String?
    var usernameText: String?
    var passwordText: String?
    
    var status: Bool{
        return emailText?.isEmpty == false && nameText?.isEmpty == false && usernameText?.isEmpty == false && passwordText?.isEmpty == false
    }
}
