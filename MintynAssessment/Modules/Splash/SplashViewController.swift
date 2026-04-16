import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let logoInitialScale: CGFloat = 0.8
        static let logoFinalScale: CGFloat = 1.0
        static let logoAnimationDuration: TimeInterval = 1.0
        static let loaderDelay: TimeInterval = 1.0
        static let transitionDelay: TimeInterval = 2.5
        static let loaderAnimationDuration: TimeInterval = 0.8
    }
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MintynSplashLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loaderContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.alpha = 0 // Hidden initially
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let loadingBars = [UIView(), UIView()]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimations()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(logoImageView)
        view.addSubview(loaderContainer)
        
        loadingBars.forEach {
            $0.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
            $0.layer.cornerRadius = 2
            $0.translatesAutoresizingMaskIntoConstraints = false
            loaderContainer.addArrangedSubview($0)
            
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: 12),
                $0.heightAnchor.constraint(equalToConstant: 4)
            ])
        }
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalToConstant: 240),
            logoImageView.heightAnchor.constraint(equalToConstant: 240),
            
            loaderContainer.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            loaderContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Animations
    private func startAnimations() {
        // Logo Scale and Fade In
        logoImageView.transform = CGAffineTransform(scaleX: Constants.logoInitialScale, y: Constants.logoInitialScale)
        
        let logoAnimator = UIViewPropertyAnimator(duration: Constants.logoAnimationDuration, curve: .easeOut) {
            self.logoImageView.alpha = 1.0
            self.logoImageView.transform = CGAffineTransform(scaleX: Constants.logoFinalScale, y: Constants.logoFinalScale)
        }
        
        logoAnimator.startAnimation()
        
        // Loader Animates in after 1s
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.loaderDelay) { [weak self] in
            self?.animateLoader()
        }
        
        // Transition to Login
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.transitionDelay) { [weak self] in
            self?.navigateToLogin()
        }
    }
    
    private func animateLoader() {
        UIView.animate(withDuration: 0.3) {
            self.loaderContainer.alpha = 1.0
        }
        
        // Pulse animation for bars
        for (index, bar) in loadingBars.enumerated() {
            let delay = TimeInterval(index) * 0.2
            UIView.animate(withDuration: Constants.loaderAnimationDuration, delay: delay, options: [.autoreverse, .repeat, .curveEaseInOut]) {
                bar.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                bar.alpha = 0.5
            }
        }
    }
    
    // MARK: - Navigation
    private func navigateToLogin() {
        let loginVC = LoginViewController()
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .fade
        
        // Clean transition to next screen without pushing memory
        guard let windowScene = view.window?.windowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        window.layer.add(transition, forKey: kCATransition)
        let navController = UINavigationController(rootViewController: loginVC)
        navController.isNavigationBarHidden = true
        window.rootViewController = navController
    }
}
