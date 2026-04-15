import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
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
        b.tintColor = UIColor(white: 0.4, alpha: 1.0)
        b.contentVerticalAlignment = .fill
        b.contentHorizontalAlignment = .fill
        b.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        return b
    }()
    
    // Balance Card (Glassmorphic dark design)
    private let balanceCard: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        v.layer.cornerRadius = 24
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        // Soft shadow
        v.layer.shadowColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 0.4).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        v.layer.shadowRadius = 12
        v.layer.shadowOpacity = 0.5
        return v
    }()
    
    private let balanceTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Total Balance"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .lightGray
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
    private let listContainer: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.08, alpha: 1.0)
        v.layer.cornerRadius = 32
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
        setupUI()
        setupBindings()
        viewModel.loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .black // Solid dark theme
        
        [headerView, welcomeLabel, avatarButton, balanceCard, balanceTitleLabel, balanceAmountLabel, actionsStackView, listContainer, transactionsTitle, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(headerView)
        headerView.addSubview(welcomeLabel)
        headerView.addSubview(avatarButton)
        
        view.addSubview(balanceCard)
        balanceCard.addSubview(balanceTitleLabel)
        balanceCard.addSubview(balanceAmountLabel)
        
        view.addSubview(actionsStackView)
        
        // Re-add generic buttons into stack
        let transferBtn = QuickActionButton(title: "Transfer", iconName: "arrow.right.arrow.left")
        let billBtn = QuickActionButton(title: "Pay Bills", iconName: "doc.text")
        let topupBtn = QuickActionButton(title: "Top Up", iconName: "iphone")
        actionsStackView.addArrangedSubview(transferBtn)
        actionsStackView.addArrangedSubview(billBtn)
        actionsStackView.addArrangedSubview(topupBtn)
        
        view.addSubview(listContainer)
        listContainer.addSubview(transactionsTitle)
        listContainer.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            
            balanceTitleLabel.topAnchor.constraint(equalTo: balanceCard.topAnchor, constant: 24),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 24),
            
            balanceAmountLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 8),
            balanceAmountLabel.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 24),
            
            actionsStackView.topAnchor.constraint(equalTo: balanceCard.bottomAnchor, constant: 24),
            actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            actionsStackView.heightAnchor.constraint(equalToConstant: 100),
            
            listContainer.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 32),
            listContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            transactionsTitle.topAnchor.constraint(equalTo: listContainer.topAnchor, constant: 32),
            transactionsTitle.leadingAnchor.constraint(equalTo: listContainer.leadingAnchor, constant: 24),
            
            tableView.topAnchor.constraint(equalTo: transactionsTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: listContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: listContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: listContainer.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.balanceAmountLabel.text = self?.viewModel.balance
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func didTapSettings() {
        // Micro animation on tap
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
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.transactions.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else { return UITableViewCell() }
        cell.configure(with: viewModel.transactions[indexPath.row])
        // Animating the cell appearance to feel dynamic
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
