//
//  RegisterViewController.swift
//  TodoList
//
//  Created by aykut ipek on 10.02.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - UIElements
    private var stackView = UIStackView()
    private var viewModel = RegisterViewModel()
    private var profileImage: UIImage?
    // MARK: - Properties
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera.circle.fill"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.cornerRadius = 150 / 2
        button.addTarget(self, action: #selector(handleGoCameraButton), for: .touchUpInside)
        return button
    }()
    private lazy var emailContainerView: UIView = {
        let emailContainer = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return emailContainer
    }()
    private lazy var nameContainerView: UIView = {
        let emailContainer = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return emailContainer
    }()
    private lazy var usernameContainerView: UIView = {
        let emailContainer = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: usernameTextField)
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
    private let nameTextField: UITextField = {
        let emailTextField = CustomTextField(textField: "Name")
        return emailTextField
    }()
    private let usernameTextField: UITextField = {
        let emailTextField = CustomTextField(textField: "Username")
        return emailTextField
    }()
    private let passwordTextField: UITextField = {
        let passwordTextField = CustomTextField(textField: "Password")
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    private lazy var switchToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already are member? Sign in", attributes: [.foregroundColor: UIColor.white,.font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoLogin), for: .touchUpInside)
        return button
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Selector
extension RegisterViewController{
    @objc private func handleGoLogin(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    @objc private func handleTextField(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.emailText = sender.text
        }else if sender == nameTextField{
            viewModel.nameText = sender.text
        }else if sender == usernameTextField{
            viewModel.usernameText = sender.text
        }else{
            viewModel.passwordText = sender.text
        }
        registerButtonStatus()
    }
    @objc private func handleGoCameraButton(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
    @objc private func handleRegisterButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else {return}
        guard let nameText = nameTextField.text else {return}
        guard let usernameText = usernameTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        guard let profileImage = self.profileImage else {return}
        showHud(show: true)
        let user = AuthenticationRegisterUserModel(emailText: emailText, passwordText: passwordText, usernameText: usernameText, nameText: nameText, profileImage: profileImage)
        AuthenticationService.createUser(user: user) { error in
            if let error = error{
                print("Error\(error.localizedDescription)")
                self.showHud(show: false)
                return
            }
            self.showHud(show: false)
            self.dismiss(animated: true)
        }
    }
    @objc private func handleKeyboardWillShow(){
        self.view.frame.origin.y = -110
    }
    @objc private func handleKeyboardDidShow(){
        self.view.frame.origin.y = 0
    }
}

// MARK: - Helpers
extension RegisterViewController{
    private func setupUI(){
        style()
        layout()
        configureGradient()
    }
    private func style(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.isHidden = true
        
        emailTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        
        //Stack View Style
        stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,usernameContainerView,passwordContainerView,registerButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        switchToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(cameraButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginButton)
        
        NSLayoutConstraint.activate([
            cameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 150),
            cameraButton.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            switchToLoginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            switchToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func registerButtonStatus(){
        if viewModel.status{
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else{
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension RegisterViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profileImage = image
        cameraButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        cameraButton.clipsToBounds = true
        cameraButton.layer.cornerRadius = 150 / 2
        cameraButton.contentMode = .scaleAspectFill
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 3
        self.dismiss(animated: true)
    }
}
