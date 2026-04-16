import UIKit

class TransferViewController: UIViewController {
    
    private let tabLine = UIView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        setupUI()
    }
    
    private func setupUI() {
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        let backBtn = UIButton(type: .system)
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        backBtn.backgroundColor = UIColor(red: 0.95, green: 0.85, blue: 0.6, alpha: 0.2)
        backBtn.layer.cornerRadius = 16
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        headerView.addSubview(backBtn)
        
        let titleLabel = UILabel()
        titleLabel.text = "New Money Transfer"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let sendMoneyTo = UILabel()
        sendMoneyTo.text = "Send Money to"
        sendMoneyTo.textColor = .black
        sendMoneyTo.font = .systemFont(ofSize: 16, weight: .medium)
        sendMoneyTo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendMoneyTo)
        
        let stackGrid = UIStackView()
        stackGrid.axis = .horizontal
        stackGrid.spacing = 16
        stackGrid.distribution = .fillEqually
        stackGrid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackGrid)
        
        let newRec = buildSquareOption(title: "New Recipient", icon: "wallet.pass")
        let savedRec = buildSquareOption(title: "Saved Recipient", icon: "doc.text")
        stackGrid.addArrangedSubview(newRec)
        stackGrid.addArrangedSubview(savedRec)
        
        let tabsStack = UIStackView()
        tabsStack.axis = .horizontal
        tabsStack.distribution = .fillEqually
        tabsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabsStack)
        
        let t1 = UILabel()
        t1.text = "Frequents"
        t1.textAlignment = .center
        t1.textColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        t1.font = .systemFont(ofSize: 14, weight: .medium)
        
        let t2 = UILabel()
        t2.text = "Recent Recipients"
        t2.textAlignment = .center
        t2.textColor = .black
        t2.font = .systemFont(ofSize: 14, weight: .medium)
        
        tabsStack.addArrangedSubview(t1)
        tabsStack.addArrangedSubview(t2)
        
        let tabBaseLine = UIView()
        tabBaseLine.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        tabBaseLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBaseLine)
        
        tabLine.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        tabLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabLine)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            backBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            backBtn.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: 32),
            backBtn.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            sendMoneyTo.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            sendMoneyTo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackGrid.topAnchor.constraint(equalTo: sendMoneyTo.bottomAnchor, constant: 16),
            stackGrid.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackGrid.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackGrid.heightAnchor.constraint(equalToConstant: 120),
            
            tabsStack.topAnchor.constraint(equalTo: stackGrid.bottomAnchor, constant: 32),
            tabsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tabsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tabBaseLine.topAnchor.constraint(equalTo: tabsStack.bottomAnchor, constant: 12),
            tabBaseLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tabBaseLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tabBaseLine.heightAnchor.constraint(equalToConstant: 2),
            
            tabLine.topAnchor.constraint(equalTo: tabBaseLine.topAnchor),
            tabLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tabLine.widthAnchor.constraint(equalTo: tabsStack.widthAnchor, multiplier: 0.5),
            tabLine.heightAnchor.constraint(equalToConstant: 2),
            
            tableView.topAnchor.constraint(equalTo: tabBaseLine.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func buildSquareOption(title: String, icon: String) -> UIView {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 16
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.05
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        v.layer.shadowRadius = 8
        
        let iconCircle = UIView()
        iconCircle.backgroundColor = UIColor(red: 0.95, green: 0.85, blue: 0.6, alpha: 0.3)
        iconCircle.layer.cornerRadius = 20
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(iconCircle)
        
        let iv = UIImageView(image: UIImage(systemName: icon))
        iv.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iconCircle.addSubview(iv)
        
        let l = UILabel()
        l.text = title
        l.textColor = .black
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(l)
        
        NSLayoutConstraint.activate([
            iconCircle.centerXAnchor.constraint(equalTo: v.centerXAnchor),
            iconCircle.topAnchor.constraint(equalTo: v.topAnchor, constant: 24),
            iconCircle.widthAnchor.constraint(equalToConstant: 40),
            iconCircle.heightAnchor.constraint(equalToConstant: 40),
            
            iv.centerXAnchor.constraint(equalTo: iconCircle.centerXAnchor),
            iv.centerYAnchor.constraint(equalTo: iconCircle.centerYAnchor),
            iv.widthAnchor.constraint(equalToConstant: 20),
            iv.heightAnchor.constraint(equalToConstant: 20),
            
            l.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -20),
            l.centerXAnchor.constraint(equalTo: v.centerXAnchor)
        ])
        return v
    }
    
    @objc private func didTapClose() { dismiss(animated: true) }
}

extension TransferViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 10 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Paul Dureke"
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        cell.detailTextLabel?.text = "0023849310 - Zenith Bank"
        cell.detailTextLabel?.textColor = .gray
        
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        v.layer.cornerRadius = 12
        cell.selectedBackgroundView = v
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 70 }
}
