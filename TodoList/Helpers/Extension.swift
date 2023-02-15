//
//  Extension.swift
//  TodoList
//
//  Created by aykut ipek on 9.02.2023.
//

import UIKit
import JGProgressHUD

extension UIViewController{
    func configureGradient(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemCyan.cgColor, UIColor.systemBlue.cgColor]
        gradient.frame = view.bounds
        gradient.zPosition = -1
        view.layer.addSublayer(gradient)
    }
    func showHud(show: Bool){
        view.endEditing(true)
        let jgProgressHud = JGProgressHUD(style: .dark)
        jgProgressHud.textLabel.text = "Loading"
        jgProgressHud.detailTextLabel.text = "Please Wait"
        if show{
            jgProgressHud.show(in: view)
        }else{
            jgProgressHud.dismiss(animated: true)
        }
    }
}

extension UIColor{
    static let mainColor = UIColor.systemBlue.withAlphaComponent(0.7)
}
