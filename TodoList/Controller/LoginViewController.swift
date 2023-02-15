//
//  ViewController.swift
//  TodoList
//
//  Created by aykut ipek on 9.02.2023.
//
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UIElements
    private var stackView = UIStackView()
    private var viewModel = LoginViewModel()
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "timelapse")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    private lazy var emailContainerView: UIView = {
        let emailContainer = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return emailContainer
    }()
    private lazy var passwordContainerView: UIView = {
        let passwordContainer = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return passwordContainer
    }()
    private let emailTextField: UITextField = {
        let emailTextField = CustomTextField(textField: "Email")
        return emailTextField
    }()
    private let passwordTextField: UITextField = {
        let passwordTextField = CustomTextField(textField: "Password")
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    private lazy var switchToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click To Become a Member", attributes: [.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoRegister), for: .touchUpInside)
        return button
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Helpers
extension LoginViewController{
    @objc private func handleTextField(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.emailText = sender.text
        }else{
            viewModel.passwordText = sender.text
        }
        loginButtonStatus()
    }
    @objc private func handleGoRegister(_ sender: UIButton){
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    @objc private func handleLoginButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        showHud(show: true)
        AuthenticationService.login(emailText: emailText, passwordText: passwordText) { result, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                self.showHud(show: false)
                return
            }
            self.showHud(show: false)
            self.dismiss(animated: true)
        }
    }
}

// MARK: - Helpers
extension LoginViewController{
    private func setupUI(){
        style()
        layout()
        configureGradient()
    }
    private func style(){
        //Logo Image View Style
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.cornerRadius = 150 / 2
        
        //Email Container View Style
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        //Password Container View Style
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        //Email and Password Target
        emailTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
       
        //Login Button Style
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Stack View Style
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Switch To Registeration Page
        switchToRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchToRegisterButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            switchToRegisterButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            switchToRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func loginButtonStatus(){
        if viewModel.status{
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}

