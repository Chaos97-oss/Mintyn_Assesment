import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - ViewModel
    private let viewModel = HomeViewModel()
    
    // MARK: - UI Components
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Good Morning, User"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        button.tintColor = .secondaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        return button
    }()
    
    // Balance Card
    private let balanceCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Balance"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Quick Actions
    private let actionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Transactions
    private let transactionsTitle: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        headerView.addSubview(welcomeLabel)
        headerView.addSubview(profileButton)
        
        view.addSubview(balanceCard)
        balanceCard.addSubview(balanceTitleLabel)
        balanceCard.addSubview(balanceAmountLabel)
        
        view.addSubview(actionsStackView)
        let transferBtn = QuickActionButton(title: "Transfer", iconName: "arrow.right.arrow.left")
        let billBtn = QuickActionButton(title: "Pay Bills", iconName: "doc.text")
        let topupBtn = QuickActionButton(title: "Top Up", iconName: "plus.circle")
        
        actionsStackView.addArrangedSubview(transferBtn)
        actionsStackView.addArrangedSubview(billBtn)
        actionsStackView.addArrangedSubview(topupBtn)
        
        view.addSubview(transactionsTitle)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            welcomeLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            
            profileButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            profileButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
            balanceCard.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            balanceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            balanceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            balanceCard.heightAnchor.constraint(equalToConstant: 120),
            
            balanceTitleLabel.topAnchor.constraint(equalTo: balanceCard.topAnchor, constant: 20),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 20),
            
            balanceAmountLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 8),
            balanceAmountLabel.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 20),
            
            actionsStackView.topAnchor.constraint(equalTo: balanceCard.bottomAnchor, constant: 24),
            actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionsStackView.heightAnchor.constraint(equalToConstant: 90),
            
            transactionsTitle.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 32),
            transactionsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: transactionsTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    @objc private func didTapProfile() {
        // We will navigate to Settings when profile is tapped. Wait, we need a SettingsViewController placeholder to compile correctly if it's there.
        // I'll create a class placeholder at the bottom if needed or instantiate directly.
        // Actually I should navigate to Settings.
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
