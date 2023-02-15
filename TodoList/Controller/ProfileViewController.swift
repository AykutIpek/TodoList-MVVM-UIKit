//
//  ProfileViewController.swift
//  TodoList
//
//  Created by aykut ipek on 11.02.2023.
//

import UIKit
import SDWebImage
import FirebaseAuth

class ProfileViewController: UIViewController {
    // MARK: - UIElements
    var user: User?{
        didSet { configure() }
    }
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameContainer: CustomProfileView = {
        let nameContainer = CustomProfileView(label: nameLabel)
        return nameContainer
    }()
    private let nameLabel = UILabel()
    private lazy var emailContainer: CustomProfileView = {
        let emailContainer = CustomProfileView(label: emailLabel)
        return emailContainer
    }()
    private let emailLabel = UILabel()
    private lazy var usernameContainer: CustomProfileView = {
        let usernameContainer = CustomProfileView(label: usernameLabel)
        return usernameContainer
    }()
    private let usernameLabel = UILabel()
    private lazy var signOutButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignOutButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    private var stackView = UIStackView()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Selector
extension ProfileViewController{
    @objc private func handleSignOutButton(){
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }catch{
            
        }
    }
}

// MARK: - Helpers
extension ProfileViewController{
    private func setupUI(){
        style()
        layout()
        configureGradient()
    }
    private func style(){
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 160 / 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        
        stackView = UIStackView(arrangedSubviews: [emailContainer,usernameContainer, nameContainer, signOutButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(profileImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: 160),
            profileImageView.widthAnchor.constraint(equalToConstant: 160),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 32),
        ])
    }
    
    private func attributedTitle(title: String, info: String)-> NSMutableAttributedString{
        let attributedTitle = NSMutableAttributedString(string: "\(title): ",attributes: [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .title2)])
        attributedTitle.append(NSAttributedString(string: info, attributes: [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .title3)]))
        return attributedTitle
    }
    
    private func configure(){
        guard let user = self.user else { return }
        let viewModel = ProfileViewModel(user: user)
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        self.nameLabel.attributedText = attributedTitle(title: "Name", info: viewModel.name!)
        self.emailLabel.attributedText = attributedTitle(title: "Email", info: viewModel.email!)
        self.usernameLabel.attributedText = attributedTitle(title: "Username", info: viewModel.username!)
    }
}

