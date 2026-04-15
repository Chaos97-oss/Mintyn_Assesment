import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    // Liquid Glass Animated Orbs
    private let orb1 = UIView()
    private let orb2 = UIView()
    
    // UI Elements
    private let headerView = UIView()
    private let welcomeLabel: UILabel = {
        let l = UILabel()
        l.text = "Good morning,\nUser"
        l.numberOfLines = 2
        l.font = .systemFont(ofSize: 22, weight: .bold)
        l.textColor = .white
        return l
    }()
    
    private lazy var avatarButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        b.tintColor = UIColor(white: 0.8, alpha: 1.0)
        b.contentVerticalAlignment = .fill
        b.contentHorizontalAlignment = .fill
        b.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        return b
    }()
    
    // Balance Card (Liquid Glassmorphic design)
    private let balanceCard: UIVisualEffectView = {
        // systemUltraThinMaterialDark is perfect for glassmorphism
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let v = UIVisualEffectView(effect: blurEffect)
        v.layer.cornerRadius = 24
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        v.clipsToBounds = true
        return v
    }()
    
    private let balanceTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Total Balance"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = UIColor(white: 0.85, alpha: 1.0)
        return l
    }()
    
    private let balanceAmountLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 36, weight: .bold)
        l.textColor = .white
        return l
    }()
    
    // Action Stack
    private let actionsStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.spacing = 16
        s.distribution = .fillEqually
        return s
    }()
    
    // Transactions
    private let listContainer: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let v = UIVisualEffectView(effect: blur)
        v.layer.cornerRadius = 32
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.clipsToBounds = true
        return v
    }()
    
    private let transactionsTitle: UILabel = {
        let l = UILabel()
        l.text = "Recent Transactions"
        l.font = .systemFont(ofSize: 18, weight: .semibold)
        l.textColor = .white
        return l
    }()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.backgroundColor = .clear
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        t.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLiquidGlassBackground()
        setupUI()
        setupBindings()
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLiquidOrbs()
    }
    
    private func setupLiquidGlassBackground() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1.0)
        
        // Orb 1 - Gold/Mintyn Color
        orb1.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 0.4)
        orb1.layer.cornerRadius = 100
        orb1.frame = CGRect(x: -50, y: 100, width: 200, height: 200)
        view.addSubview(orb1)
        
        // Orb 2 - Deep Purple/Blue for premium contrast
        orb2.backgroundColor = UIColor(red: 0.3, green: 0.1, blue: 0.5, alpha: 0.4)
        orb2.layer.cornerRadius = 150
        orb2.frame = CGRect(x: view.bounds.width - 150, y: 300, width: 300, height: 300)
        view.addSubview(orb2)
        
        // Massive Blur Overlay to create Liquid Glass Effect
        let blurOverlay = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurOverlay.frame = view.bounds
        blurOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurOverlay)
    }
    
    private func animateLiquidOrbs() {
        // Infinite subtle animations for the liquid background
        UIView.animate(withDuration: 8.0, delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
            self.orb1.transform = CGAffineTransform(translationX: 100, y: 50).scaledBy(x: 1.2, y: 1.2)
            self.orb2.transform = CGAffineTransform(translationX: -80, y: -100).scaledBy(x: 0.8, y: 0.8)
        })
    }
    
    private func setupUI() {
        [headerView, welcomeLabel, avatarButton, balanceCard, actionsStackView, listContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        headerView.addSubview(welcomeLabel)
        headerView.addSubview(avatarButton)
        
        balanceCard.contentView.addSubview(balanceTitleLabel)
        balanceCard.contentView.addSubview(balanceAmountLabel)
        balanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Re-add generic buttons into stack
        let transferBtn = QuickActionButton(title: "Transfer", iconName: "arrow.right.arrow.left")
        transferBtn.addTarget(self, action: #selector(didTapTransfer), for: .touchUpInside)
        
        let billBtn = QuickActionButton(title: "Pay Bills", iconName: "doc.text")
        billBtn.addTarget(self, action: #selector(didTapBills), for: .touchUpInside)
        
        let topupBtn = QuickActionButton(title: "Top Up", iconName: "iphone")
        topupBtn.addTarget(self, action: #selector(didTapTopUp), for: .touchUpInside)
        
        actionsStackView.addArrangedSubview(transferBtn)
        actionsStackView.addArrangedSubview(billBtn)
        actionsStackView.addArrangedSubview(topupBtn)
        
        listContainer.contentView.addSubview(transactionsTitle)
        listContainer.contentView.addSubview(tableView)
        transactionsTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            headerView.heightAnchor.constraint(equalToConstant: 70),
            
            welcomeLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            
            avatarButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            avatarButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            avatarButton.widthAnchor.constraint(equalToConstant: 44),
            avatarButton.heightAnchor.constraint(equalToConstant: 44),
            
            balanceCard.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            balanceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            balanceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            balanceCard.heightAnchor.constraint(equalToConstant: 130),
            
            balanceTitleLabel.topAnchor.constraint(equalTo: balanceCard.contentView.topAnchor, constant: 24),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: balanceCard.contentView.leadingAnchor, constant: 24),
            
            balanceAmountLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 8),
            balanceAmountLabel.leadingAnchor.constraint(equalTo: balanceCard.contentView.leadingAnchor, constant: 24),
            
            actionsStackView.topAnchor.constraint(equalTo: balanceCard.bottomAnchor, constant: 24),
            actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            actionsStackView.heightAnchor.constraint(equalToConstant: 100),
            
            listContainer.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 32),
            listContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            transactionsTitle.topAnchor.constraint(equalTo: listContainer.contentView.topAnchor, constant: 32),
            transactionsTitle.leadingAnchor.constraint(equalTo: listContainer.contentView.leadingAnchor, constant: 24),
            
            tableView.topAnchor.constraint(equalTo: transactionsTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: listContainer.contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: listContainer.contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: listContainer.contentView.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.balanceAmountLabel.text = "₦450,000.00" // Formatted example
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func didTapSettings() {
        UIView.animate(withDuration: 0.1, animations: {
            self.avatarButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.avatarButton.transform = .identity
            }
            let settingsVC = SettingsViewController()
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    // Quick Actions
    private func presentFeature(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapTransfer() { presentFeature(TransferViewController()) }
    @objc private func didTapBills() { presentFeature(PayBillsViewController()) }
    @objc private func didTapTopUp() { presentFeature(TopUpViewController()) }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.transactions.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else { return UITableViewCell() }
        cell.configure(with: viewModel.transactions[indexPath.row])
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 10)
        UIView.animate(withDuration: 0.3, delay: Double(indexPath.row) * 0.05, options: .curveEaseOut, animations: {
            cell.alpha = 1
            cell.transform = .identity
        }, completion: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 76 }
}
