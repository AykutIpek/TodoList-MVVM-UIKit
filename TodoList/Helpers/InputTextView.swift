//
//  InputTextView.swift
//  TodoList
//
//  Created by aykut ipek on 11.02.2023.
//
import UIKit

class InputTextView: UITextView {
    // MARK: - Properties
    var placeHolder: String? {
        didSet{ self.inputPlaceholder.text = placeHolder }
    }
    private let inputPlaceholder: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputTextView{
    @objc private func handleTextView(){
        self.inputPlaceholder.isHidden = !text.isEmpty
    }
}

// MARK: - Helpers
extension InputTextView{
    private func setupUI(){
        style()
        layout()
    }
    private func style(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextView), name: UITextView.textDidChangeNotification, object: nil)
        inputPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        textColor = .black
        font = UIFont.systemFont(ofSize: 20)
        layer.borderColor = UIColor.mainColor.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
    private func layout(){
        addSubview(inputPlaceholder)
        
        NSLayoutConstraint.activate([
            inputPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            inputPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
        ])
    }
}
