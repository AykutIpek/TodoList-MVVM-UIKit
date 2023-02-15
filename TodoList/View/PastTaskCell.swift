//
//  PastTaskCell.swift
//  TodoList
//
//  Created by aykut ipek on 14.02.2023.
//
import UIKit

class PastTaskCell: UICollectionViewCell {
    // MARK: - Properties
    var task: Task?{
        didSet {configure()}
    }
    private lazy var circleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .black
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension PastTaskCell{
    private func setupUI(){
        style()
        layout()
    }
    private func style(){
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 5
        
        //Circle Button
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Task Label
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(circleButton)
        addSubview(taskLabel)
        
        NSLayoutConstraint.activate([
            circleButton.heightAnchor.constraint(equalToConstant: 50),
            circleButton.widthAnchor.constraint(equalToConstant: 50),
            circleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            taskLabel.leadingAnchor.constraint(equalTo: circleButton.trailingAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: taskLabel.trailingAnchor, constant: 8),
            bottomAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 8)
        ])
    }
    private func configure(){
        guard let task = self.task else { return }
        taskLabel.text = task.text
    }
}

