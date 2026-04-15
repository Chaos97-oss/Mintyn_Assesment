import UIKit

class SettingsViewController: UIViewController {
    
    private let viewModel = SettingsViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Settings"
    }
    
    private func setupUI() {
        let background = LiquidBackgroundView(frame: view.bounds)
        background.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(background)
        view.sendSubviewToBack(background)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let option = viewModel.sections[indexPath.section].options[indexPath.row]
        
        cell.textLabel?.text = option.title
        cell.imageView?.image = UIImage(systemName: option.iconName)
        cell.imageView?.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        
        cell.backgroundColor = UIColor(white: 0.1, alpha: 0.6)
        cell.textLabel?.textColor = .white
        
        if option.title == "Logout" {
             cell.textLabel?.textColor = .systemRed
             cell.imageView?.tintColor = .systemRed
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = viewModel.sections[indexPath.section].options[indexPath.row]
        
        if option.title == "Logout" {
            let loginVC = LoginViewController()
            guard let window = view.window else { return }
            window.rootViewController = loginVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        } else {
            let alert = UIAlertController(title: option.title, message: "Setting feature not implemented.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
