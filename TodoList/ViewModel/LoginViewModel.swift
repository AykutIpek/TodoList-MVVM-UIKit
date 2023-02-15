//
//  LoginViewModel.swift
//  TodoList
//
//  Created by aykut ipek on 10.02.2023.
//

import Foundation

struct LoginViewModel{
    var emailText: String?
    var passwordText: String?
    
    var status: Bool{
        return emailText?.isEmpty == false && passwordText?.isEmpty == false
    }
}
