import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - ViewModel
    private let viewModel = LoginViewModel()
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailField: PaddingTextField = {
        let field = PaddingTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.lightGray])
        field.keyboardType = .emailAddress
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: PaddingTextField = {
        let field = PaddingTextField()
        field.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.lightGray])
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .black // Follow Mintyn dark theme aesthetic
        
        let wrapperView = UIView()
        wrapperView.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        wrapperView.layer.cornerRadius = 24
        wrapperView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(wrapperView)
        
        wrapperView.addSubview(emailField)
        wrapperView.addSubview(passwordField)
        wrapperView.addSubview(loginButton)
        loginButton.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            wrapperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65), // Covers bottom 65% visually
            
            emailField.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        // Tap to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            if isLoading {
                self?.loginButton.setTitle("", for: .normal)
                self?.activityIndicator.startAnimating()
                self?.loginButton.isEnabled = false
            } else {
                self?.loginButton.setTitle("Login", for: .normal)
                self?.activityIndicator.stopAnimating()
                self?.loginButton.isEnabled = true
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showAlert(title: "Error", message: errorMessage)
        }
        
        viewModel.onSuccess = { [weak self] in
            let homeVC = HomeViewController()
            // We usually want an actual navigation flow here. Let's make Home the root.
            guard let window = self?.view.window else { return }
            let nav = UINavigationController(rootViewController: homeVC)
            window.rootViewController = nav
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    // MARK: - Actions
    @objc private func didTapLogin() {
        dismissKeyboard()
        viewModel.login(email: emailField.text, password: passwordField.text)
    }
    
    // MARK: - Helpers
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

