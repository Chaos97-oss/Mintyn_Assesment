import UIKit

class PhoneNumberField: UIView {
    
    let textField: UITextField = {
        let field = UITextField()
        field.keyboardType = .phonePad
        field.textColor = .white
        field.font = .systemFont(ofSize: 16)
        field.attributedPlaceholder = NSAttributedString(string: "802 123 4567", attributes: [.foregroundColor: UIColor.lightGray])
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let flagLabel: UILabel = {
        let label = UILabel()
        label.text = "🇳🇬"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "+234"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Function to dynamically shift to error layout
    func setErrorState(isError: Bool) {
        if isError {
            layer.borderColor = UIColor.red.cgColor
        } else {
            layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        }
    }
    
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
        
        addSubview(flagLabel)
        addSubview(countryCodeLabel)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            flagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            flagLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            countryCodeLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 8),
            countryCodeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            textField.leadingAnchor.constraint(equalTo: countryCodeLabel.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
