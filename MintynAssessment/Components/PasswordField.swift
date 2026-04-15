import UIKit

class PasswordField: UIView {
    
    let textField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.textColor = .white
        field.font = .systemFont(ofSize: 16)
        field.attributedPlaceholder = NSAttributedString(string: "********", attributes: [.foregroundColor: UIColor.lightGray])
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let toggleEyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        addSubview(textField)
        addSubview(toggleEyeButton)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            toggleEyeButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            toggleEyeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            toggleEyeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            toggleEyeButton.widthAnchor.constraint(equalToConstant: 24),
            toggleEyeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        toggleEyeButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
    }
    
    @objc private func toggleVisibility() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye" : "eye.slash"
        toggleEyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
