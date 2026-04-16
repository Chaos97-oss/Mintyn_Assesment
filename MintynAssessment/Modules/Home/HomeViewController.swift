import UIKit

// Represents the quick access item
struct QuickAccessItem { let title: String; let icon: String }
// Represents the color grid item
struct ColorGridItem { let title: String; let color: UIColor; let icon: String }

class HomeViewController: UIViewController {
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerStack = UIStackView()
    private let accountStack = UIStackView()
    
    private let balanceCard = UIView()
    private let updateAccountView = UIView()
    
    private let colorGridStack = UIStackView()
    private let quickAccessLabel = UILabel()
    private let quickAccessGrid = UIStackView()
    
    private let amtLabel = UILabel()
    private let ledgerLabel = UILabel()
    private let hideBtn = UIButton(type: .system)
    private var isBalanceHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupScrollView()
        buildHeader()
        buildAccountInfo()
        buildBalanceCard()
        buildUpdateAccount()
        buildColorGrid()
        buildQuickAccess()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupBackground() {
        view.backgroundColor = .black
        let liquid = LiquidBackgroundView(frame: view.bounds)
        liquid.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(liquid)
        view.sendSubviewToBack(liquid)
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            // Critical fail-safe bounding forcing the exact height offset computation structurally.
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor, constant: 1)
        ])
    }
    
    private func buildHeader() {
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerStack)
        
        // Logo Fake
        let logoLabel = UILabel()
        logoLabel.text = "MINTYN"
        logoLabel.font = .systemFont(ofSize: 18, weight: .bold)
        let logoImage = UIImageView(image: UIImage(named: "MintynLogo"))
        logoImage.contentMode = .scaleAspectFit
        logoImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        let logoStack = UIStackView(arrangedSubviews: [logoImage, logoLabel])
        logoStack.spacing = 8
        logoLabel.textColor = .white
        
        // Rights icons
        let chartIcon = UIImageView(image: UIImage(systemName: "chart.bar.fill"))
        chartIcon.tintColor = .gray
        
        let bellBtn = UIButton(type: .system)
        bellBtn.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        bellBtn.tintColor = .white
        bellBtn.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        bellBtn.layer.cornerRadius = 18
        bellBtn.widthAnchor.constraint(equalToConstant: 36).isActive = true
        bellBtn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        bellBtn.addTarget(self, action: #selector(didTapBell), for: .touchUpInside)
        
        let rightStack = UIStackView(arrangedSubviews: [chartIcon, bellBtn])
        rightStack.spacing = 16
        rightStack.alignment = .center
        
        headerStack.addArrangedSubview(logoStack)
        headerStack.addArrangedSubview(rightStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func buildAccountInfo() {
        accountStack.axis = .horizontal
        accountStack.spacing = 12
        accountStack.alignment = .center
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(accountStack)
        
        let avatar = UIImageView()
        avatar.backgroundColor = .systemGray
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        avatar.widthAnchor.constraint(equalToConstant: 40).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        avatar.image = UIImage(systemName: "person.crop.circle.fill")
        avatar.tintColor = .white
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        let name = UILabel()
        name.text = "Tunde Lasisi"
        name.textColor = .white
        name.font = .systemFont(ofSize: 16, weight: .semibold)
        
        let tierLabel = UILabel()
        let tStr = NSMutableAttributedString(string: "Individual • 11289438943 • ", attributes: [.foregroundColor: UIColor.gray])
        tStr.append(NSAttributedString(string: "Tier 1", attributes: [.foregroundColor: UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)]))
        tierLabel.attributedText = tStr
        tierLabel.font = .systemFont(ofSize: 12)
        
        vStack.addArrangedSubview(name)
        vStack.addArrangedSubview(tierLabel)
        
        let switchStack = UIStackView()
        switchStack.axis = .vertical
        switchStack.alignment = .trailing
        let switchLabel = UILabel()
        switchLabel.text = "Switch Account"
        switchLabel.textColor = .white
        switchLabel.font = .systemFont(ofSize: 12)
        let dropIcon = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
        dropIcon.tintColor = .gray
        dropIcon.widthAnchor.constraint(equalToConstant: 10).isActive = true
        dropIcon.heightAnchor.constraint(equalToConstant: 10).isActive = true
        switchStack.addArrangedSubview(switchLabel)
        switchStack.addArrangedSubview(dropIcon)
        switchStack.isUserInteractionEnabled = true
        switchStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSwitchAccount)))
        
        accountStack.addArrangedSubview(avatar)
        accountStack.addArrangedSubview(vStack)
        accountStack.addArrangedSubview(UIView()) // spacer
        accountStack.addArrangedSubview(switchStack)
        
        NSLayoutConstraint.activate([
            accountStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 32),
            accountStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            accountStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func buildBalanceCard() {
        balanceCard.backgroundColor = UIColor(white: 0.12, alpha: 1.0)
        balanceCard.layer.cornerRadius = 20
        balanceCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(balanceCard)
        
        amtLabel.text = "₦500,000.00"
        amtLabel.font = .systemFont(ofSize: 26, weight: .bold)
        amtLabel.textColor = .white
        amtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let addMoneyBtn = UIButton(type: .system)
        addMoneyBtn.setTitle("+ ADD MONEY", for: .normal)
        addMoneyBtn.setTitleColor(.white, for: .normal)
        addMoneyBtn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        addMoneyBtn.backgroundColor = UIColor(red: 0.7, green: 0.5, blue: 0.15, alpha: 1.0)
        addMoneyBtn.layer.cornerRadius = 8
        addMoneyBtn.translatesAutoresizingMaskIntoConstraints = false
        addMoneyBtn.addTarget(self, action: #selector(didTapAddMoney), for: .touchUpInside)
        
        let sep = UIView()
        sep.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        sep.translatesAutoresizingMaskIntoConstraints = false
        
        ledgerLabel.text = "Ledger balance:\n₦500,000,000.00"
        ledgerLabel.numberOfLines = 2
        ledgerLabel.font = .systemFont(ofSize: 12)
        ledgerLabel.textColor = .lightGray
        ledgerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hideBtn.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        hideBtn.setTitle(" Hide Balance", for: .normal)
        hideBtn.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        hideBtn.titleLabel?.font = .systemFont(ofSize: 12)
        hideBtn.translatesAutoresizingMaskIntoConstraints = false
        hideBtn.addTarget(self, action: #selector(didTapHideBalance), for: .touchUpInside)
        
        balanceCard.addSubview(amtLabel)
        balanceCard.addSubview(addMoneyBtn)
        balanceCard.addSubview(sep)
        balanceCard.addSubview(ledgerLabel)
        balanceCard.addSubview(hideBtn)
        
        NSLayoutConstraint.activate([
            balanceCard.topAnchor.constraint(equalTo: accountStack.bottomAnchor, constant: 24),
            balanceCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            balanceCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            amtLabel.topAnchor.constraint(equalTo: balanceCard.topAnchor, constant: 24),
            amtLabel.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 20),
            
            addMoneyBtn.centerYAnchor.constraint(equalTo: amtLabel.centerYAnchor),
            addMoneyBtn.trailingAnchor.constraint(equalTo: balanceCard.trailingAnchor, constant: -20),
            addMoneyBtn.widthAnchor.constraint(equalToConstant: 100),
            addMoneyBtn.heightAnchor.constraint(equalToConstant: 32),
            
            sep.topAnchor.constraint(equalTo: amtLabel.bottomAnchor, constant: 24),
            sep.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 20),
            sep.trailingAnchor.constraint(equalTo: balanceCard.trailingAnchor, constant: -20),
            sep.heightAnchor.constraint(equalToConstant: 1),
            
            ledgerLabel.topAnchor.constraint(equalTo: sep.bottomAnchor, constant: 16),
            ledgerLabel.leadingAnchor.constraint(equalTo: balanceCard.leadingAnchor, constant: 20),
            ledgerLabel.bottomAnchor.constraint(equalTo: balanceCard.bottomAnchor, constant: -20),
            
            hideBtn.centerYAnchor.constraint(equalTo: ledgerLabel.centerYAnchor),
            hideBtn.trailingAnchor.constraint(equalTo: balanceCard.trailingAnchor, constant: -20)
        ])
    }
    
    private func buildUpdateAccount() {
        updateAccountView.translatesAutoresizingMaskIntoConstraints = false
        updateAccountView.isUserInteractionEnabled = true
        updateAccountView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUpdateAccount)))
        contentView.addSubview(updateAccountView)
        
        let lineTop = UIView()
        lineTop.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        lineTop.translatesAutoresizingMaskIntoConstraints = false
        updateAccountView.addSubview(lineTop)
        
        let title = UILabel()
        title.text = "Update Account"
        title.textColor = .white
        title.font = .systemFont(ofSize: 16, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        updateAccountView.addSubview(title)
        
        let icon = UIImageView(image: UIImage(systemName: "info.circle.fill"))
        icon.tintColor = .systemRed
        icon.translatesAutoresizingMaskIntoConstraints = false
        updateAccountView.addSubview(icon)
        
        let desc = UILabel()
        desc.text = "Update your account to get unlimited access to your account"
        desc.textColor = .gray
        desc.font = .systemFont(ofSize: 13)
        desc.numberOfLines = 2
        desc.translatesAutoresizingMaskIntoConstraints = false
        updateAccountView.addSubview(desc)
        
        let arr = UIImageView(image: UIImage(systemName: "chevron.right"))
        arr.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        arr.translatesAutoresizingMaskIntoConstraints = false
        updateAccountView.addSubview(arr)
        
        NSLayoutConstraint.activate([
            updateAccountView.topAnchor.constraint(equalTo: balanceCard.bottomAnchor, constant: 24),
            updateAccountView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            updateAccountView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            lineTop.topAnchor.constraint(equalTo: updateAccountView.topAnchor),
            lineTop.leadingAnchor.constraint(equalTo: updateAccountView.leadingAnchor),
            lineTop.trailingAnchor.constraint(equalTo: updateAccountView.trailingAnchor),
            lineTop.heightAnchor.constraint(equalToConstant: 1),
            
            title.topAnchor.constraint(equalTo: lineTop.bottomAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: updateAccountView.leadingAnchor),
            
            icon.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            icon.leadingAnchor.constraint(equalTo: updateAccountView.leadingAnchor),
            icon.widthAnchor.constraint(equalToConstant: 16),
            icon.heightAnchor.constraint(equalToConstant: 16),
            
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            desc.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            desc.trailingAnchor.constraint(equalTo: arr.leadingAnchor, constant: -16),
            desc.bottomAnchor.constraint(equalTo: updateAccountView.bottomAnchor),
            
            arr.centerYAnchor.constraint(equalTo: desc.centerYAnchor),
            arr.trailingAnchor.constraint(equalTo: updateAccountView.trailingAnchor)
        ])
    }
    
    private func buildColorGrid() {
        colorGridStack.axis = .horizontal
        colorGridStack.spacing = 16
        colorGridStack.distribution = .fillEqually
        colorGridStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorGridStack)
        
        let items = [
            ColorGridItem(title: "Product Updates", color: UIColor(red: 0.4, green: 0.3, blue: 0.9, alpha: 1.0), icon: "bell.badge.fill"),
            ColorGridItem(title: "Gift cards", color: UIColor(red: 0.1, green: 0.6, blue: 0.3, alpha: 1.0), icon: "gift.fill"),
            ColorGridItem(title: "Cardless", color: UIColor(red: 0.9, green: 0.1, blue: 0.2, alpha: 1.0), icon: "creditcard.fill")
        ]
        
        for item in items {
            let v = UIButton(type: .system)
            v.backgroundColor = item.color
            v.layer.cornerRadius = 16
            
            let icon = UIImageView(image: UIImage(systemName: item.icon))
            icon.tintColor = .white
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(icon)
            
            let l = UILabel()
            l.text = item.title
            l.textColor = .white
            l.font = .systemFont(ofSize: 11, weight: .medium)
            l.textAlignment = .center
            l.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(l)
            
            NSLayoutConstraint.activate([
                v.heightAnchor.constraint(equalToConstant: 110),
                icon.centerXAnchor.constraint(equalTo: v.centerXAnchor),
                icon.centerYAnchor.constraint(equalTo: v.centerYAnchor, constant: -10),
                icon.widthAnchor.constraint(equalToConstant: 30),
                icon.heightAnchor.constraint(equalToConstant: 30),
                l.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -12),
                l.centerXAnchor.constraint(equalTo: v.centerXAnchor)
            ])
            
            if item.title == "Cardless" {
                v.addTarget(self, action: #selector(didTapCardless), for: .touchUpInside)
            }
            if item.title == "Product Updates" {
                v.addTarget(self, action: #selector(didTapProducts), for: .touchUpInside)
            }
            if item.title == "Gift cards" {
                v.addTarget(self, action: #selector(didTapGiftCards), for: .touchUpInside)
            }
            
            colorGridStack.addArrangedSubview(v)
        }
        
        NSLayoutConstraint.activate([
            colorGridStack.topAnchor.constraint(equalTo: updateAccountView.bottomAnchor, constant: 32),
            colorGridStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorGridStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func buildQuickAccess() {
        let titleLine = UIView()
        titleLine.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        titleLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLine)
        
        quickAccessLabel.text = "Quick Access"
        quickAccessLabel.textColor = .white
        quickAccessLabel.font = .systemFont(ofSize: 16, weight: .medium)
        quickAccessLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quickAccessLabel)
        
        quickAccessGrid.axis = .horizontal
        quickAccessGrid.spacing = 16
        quickAccessGrid.distribution = .fillEqually
        quickAccessGrid.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quickAccessGrid)
        
        let items = [
            QuickAccessItem(title: "Transfer", icon: "arrow.right.arrow.left"),
            QuickAccessItem(title: "Top Up", icon: "iphone"),
            QuickAccessItem(title: "Pay Bill", icon: "doc.text"),
            QuickAccessItem(title: "Savings", icon: "banknote.fill")
        ]
        
        for item in items {
            let container = UIButton(type: .system)
            container.backgroundColor = UIColor(white: 0.12, alpha: 1.0)
            container.layer.cornerRadius = 16
            
            let icon = UIImageView(image: UIImage(systemName: item.icon))
            icon.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(icon)
            
            let l = UILabel()
            l.text = item.title
            l.textColor = .white
            l.font = .systemFont(ofSize: 12)
            l.textAlignment = .center
            l.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(l)
            
            NSLayoutConstraint.activate([
                container.heightAnchor.constraint(equalToConstant: 80),
                icon.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                icon.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
                icon.widthAnchor.constraint(equalToConstant: 24),
                icon.heightAnchor.constraint(equalToConstant: 24),
                l.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
                l.centerXAnchor.constraint(equalTo: container.centerXAnchor)
            ])
            
            if item.title == "Transfer" { container.addTarget(self, action: #selector(didTapTransfer), for: .touchUpInside) }
            if item.title == "Top Up" { container.addTarget(self, action: #selector(didTapTopUp), for: .touchUpInside) }
            if item.title == "Pay Bill" { container.addTarget(self, action: #selector(didTapBills), for: .touchUpInside) }
            if item.title == "Savings" { container.addTarget(self, action: #selector(didTapSavings), for: .touchUpInside) }
            
            quickAccessGrid.addArrangedSubview(container)
        }
        
        NSLayoutConstraint.activate([
            titleLine.topAnchor.constraint(equalTo: colorGridStack.bottomAnchor, constant: 32),
            titleLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLine.heightAnchor.constraint(equalToConstant: 1),
            
            quickAccessLabel.topAnchor.constraint(equalTo: titleLine.bottomAnchor, constant: 16),
            quickAccessLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            quickAccessGrid.topAnchor.constraint(equalTo: quickAccessLabel.bottomAnchor, constant: 16),
            quickAccessGrid.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quickAccessGrid.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            quickAccessGrid.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
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
    @objc private func didTapCardless() { presentFeature(CardlessATMViewController()) }
    
    @objc private func didTapBell() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc private func didTapProducts() { presentFeature(ProductUpdatesViewController()) }
    @objc private func didTapGiftCards() { presentFeature(GiftCardsViewController()) }
    @objc private func didTapSavings() { presentFeature(SavingsViewController()) }
    @objc private func didTapAddMoney() { presentFeature(AddMoneyViewController()) }
    @objc private func didTapSwitchAccount() { presentFeature(SwitchAccountViewController()) }
    @objc private func didTapUpdateAccount() { presentFeature(UpdateAccountViewController()) }
    
    @objc private func didTapHideBalance() {
        isBalanceHidden.toggle()
        if isBalanceHidden {
            amtLabel.text = "****"
            ledgerLabel.text = "Ledger balance:\n****"
            hideBtn.setTitle(" Show Balance", for: .normal)
            hideBtn.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            amtLabel.text = "₦500,000,000.00"
            ledgerLabel.text = "Ledger balance:\n₦500,000,000.00"
            hideBtn.setTitle(" Hide Balance", for: .normal)
            hideBtn.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
}
