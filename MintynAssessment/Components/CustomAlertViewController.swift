import UIKit

class CustomAlertViewController: UIViewController {
    
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        v.layer.cornerRadius = 24
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let iconCircle: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 40
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0).cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "xmark")
        iv.tintColor = UIColor(red: 0.6, green: 0.5, blue: 0.2, alpha: 1.0) // Dimmer gold
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Something went wrong"
        l.font = .systemFont(ofSize: 18, weight: .bold)
        l.textColor = .white
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let messageLabel: UILabel = {
        let l = UILabel()
        l.text = "Invalid login details."
        l.font = .systemFont(ofSize: 14)
        l.textColor = .white
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var actionButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Got it", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        b.setTitleColor(.systemBlue, for: .normal) // As seen in screenshot
        b.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        // Darker button background wrapper inside the alert
        b.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        b.layer.cornerRadius = 16
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(iconCircle)
        iconCircle.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 320),
            
            iconCircle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            iconCircle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconCircle.widthAnchor.constraint(equalToConstant: 80),
            iconCircle.heightAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: iconCircle.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 32),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            actionButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add a top border layer to actionButton to mimic typical iOS native grouped alerts visually inside the container
        let separator = UIView()
        separator.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: actionButton.topAnchor),
            separator.leadingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc private func didTapAction() {
        dismiss(animated: true)
    }
}
