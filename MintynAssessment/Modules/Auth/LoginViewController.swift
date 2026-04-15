import UIKit

struct TopCardItem {
    let title: String
    let icon: String // SF Symbol name
}

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    // Data
    private let carouselItems: [TopCardItem] = [
        TopCardItem(title: "EasyCollect", icon: "bag.fill"),
        TopCardItem(title: "CAC Business\nRegistration", icon: "doc.plaintext.fill"),
        TopCardItem(title: "Open an\nAccount", icon: "shield.fill"),
        TopCardItem(title: "Contact\nSupport", icon: "person.crop.circle.badge.questionmark.fill"),
        
        TopCardItem(title: "Maplerad\nVirtual Cards", icon: "creditcard.fill"),
        TopCardItem(title: "NCTO Card\nActivation", icon: "creditcard.circle.fill"),
        TopCardItem(title: "Insurance\nComing soon...", icon: "shield.lefthalf.filled")
    ]
    
    // UI - Header
    private let headerContainer = UIView()
    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    private let welcomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome"
        lbl.font = .systemFont(ofSize: 22, weight: .semibold)
        lbl.textColor = .white
        return lbl
    }()
    
    // UI - Carousel
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        // To fit 2 rows exactly
        let itemWidth = (UIScreen.main.bounds.width - 64) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 70)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(CarouselCardCell.self, forCellWithReuseIdentifier: CarouselCardCell.identifier)
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 2
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        pc.pageIndicatorTintColor = .darkGray
        return pc
    }()
    
    // UI - Bottom Sheet
    private let bottomSheet = UIView()
    
    private let phoneLabel: UILabel = {
        let l = UILabel()
        l.text = "Phone Number"
        l.font = .systemFont(ofSize: 14)
        l.textColor = .white
        return l
    }()
    
    private let phoneField = PhoneNumberField()
    
    private let passLabel: UILabel = {
        let l = UILabel()
        l.text = "Password"
        l.font = .systemFont(ofSize: 14)
        l.textColor = .white
        return l
    }()
    
    private let passField = PasswordField()
    
    private let rememberButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "square"), for: .normal)
        b.tintColor = .lightGray
        b.setTitle(" Remember me", for: .normal)
        b.setTitleColor(.lightGray, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 14)
        return b
    }()
    
    private let forgotButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Forgot password?", for: .normal)
        b.setTitleColor(UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 14)
        return b
    }()
    
    private let loginButton: PrimaryButton = {
        let b = PrimaryButton()
        b.setTitle("Login", for: .normal)
        return b
    }()
    
    private let registerButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Register new device", for: .normal)
        b.setTitleColor(UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 14)
        return b
    }()
    
    private let footerPoweredLabel: UILabel = {
        let l = UILabel()
        l.text = "Powered by FINEX MFB"
        l.font = .systemFont(ofSize: 10)
        l.textColor = .lightGray
        return l
    }()
    
    private let footerVersionLabel: UILabel = {
        let l = UILabel()
        l.text = "Version 1.4.09"
        l.font = .systemFont(ofSize: 10)
        l.textColor = .lightGray
        return l
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAndConstraints()
        setupActions()
    }
    
    private func setupViewAndConstraints() {
        view.backgroundColor = .black
        
        [headerContainer, backButton, welcomeLabel,
         collectionView, pageControl, bottomSheet].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bottomSheet.backgroundColor = UIColor(white: 0.12, alpha: 1.0)
        bottomSheet.layer.cornerRadius = 24
        bottomSheet.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        loginButton.addSubview(activityIndicator)
        
        [phoneLabel, phoneField, passLabel, passField,
         rememberButton, forgotButton, loginButton,
         registerButton, footerPoweredLabel, footerVersionLabel].forEach {
            bottomSheet.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Header
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 60),
            
            backButton.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            
            // Carousel
            collectionView.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 160), // 70*2 + 16 space + padding
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Bottom Sheet
            bottomSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheet.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 24),
            
            // Sheet Content
            phoneLabel.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 32),
            phoneLabel.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            
            phoneField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneField.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            phoneField.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -24),
            phoneField.heightAnchor.constraint(equalToConstant: 50),
            
            passLabel.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 24),
            passLabel.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            
            passField.topAnchor.constraint(equalTo: passLabel.bottomAnchor, constant: 8),
            passField.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            passField.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -24),
            passField.heightAnchor.constraint(equalToConstant: 50),
            
            rememberButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 16),
            rememberButton.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            
            forgotButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 16),
            forgotButton.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -24),
            
            loginButton.topAnchor.constraint(equalTo: rememberButton.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            registerButton.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            
            footerPoweredLabel.bottomAnchor.constraint(equalTo: footerVersionLabel.topAnchor, constant: -4),
            footerPoweredLabel.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            
            footerVersionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            footerVersionLabel.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        rememberButton.addTarget(self, action: #selector(didTapRemember), for: .touchUpInside)
        
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        
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
        
        viewModel.onSuccess = { [weak self] in
            let homeVC = HomeViewController()
            guard let window = self?.view.window else { return }
            let nav = UINavigationController(rootViewController: homeVC)
            nav.isNavigationBarHidden = true
            window.rootViewController = nav
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
        viewModel.onError = { [weak self] errorMsg in
            let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func didTapLogin() {
        dismissKeyboard()
        viewModel.login(phoneNumber: phoneField.textField.text, password: passField.textField.text)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapRemember() {
        let isChecked = rememberButton.image(for: .normal) == UIImage(systemName: "checkmark.square.fill")
        let newImage = isChecked ? "square" : "checkmark.square.fill"
        let newColor = isChecked ? UIColor.lightGray : UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        rememberButton.setImage(UIImage(systemName: newImage), for: .normal)
        rememberButton.tintColor = newColor
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let page = sender.currentPage
        // Use the width of the collection view including any layout offsets
        let offset = CGPoint(x: collectionView.bounds.width * CGFloat(page), y: 0)
        collectionView.setContentOffset(offset, animated: true)
    }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCardCell.identifier, for: indexPath) as! CarouselCardCell
        let item = carouselItems[indexPath.row]
        cell.configure(title: item.title, iconName: item.icon)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.bounds.width
        pageControl.currentPage = Int(offset / width)
    }
}
