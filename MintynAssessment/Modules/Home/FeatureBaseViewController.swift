import UIKit

class FeatureBaseViewController: UIViewController {
    
    let pageTitle: String
    let iconNameText: String
    
    init(title: String, icon: String) {
        self.pageTitle = title
        self.iconNameText = icon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return btn
    }()
    
    // Abstract hook for children to layout specific elements
    let mainContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    private func setupBaseUI() {
        // Shared Liquid Glass
        let bg = LiquidBackgroundView(frame: view.bounds)
        bg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(bg)
        view.sendSubviewToBack(bg)
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(iconImageView)
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainContainer)
        
        titleLabel.text = pageTitle
        iconImageView.image = UIImage(systemName: iconNameText)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            
            mainContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            mainContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
}
