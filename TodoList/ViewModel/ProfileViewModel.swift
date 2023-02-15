//
//  ProfileViewModel.swift
//  TodoList
//
//  Created by aykut ipek on 14.02.2023.
//

import Foundation


struct ProfileViewModel{
    var user: User
    init(user: User) {
        self.user = user
    }
    
    var profileImageUrl: URL?{
        return URL(string: user.profileImageUrl)
    }
    
    var name: String?{
        return user.name
    }
    var username: String?{
        return user.username
    }
    var email: String?{
        return user.email
    }
}
