import UIKit

class PayBillsViewController: UIViewController {
    
    private let tabLine = UIView()
    
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
        titleLabel.text = "Pay Bills"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        let tabsStack = UIStackView()
        tabsStack.axis = .horizontal
        tabsStack.distribution = .fillEqually
        tabsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabsStack)
        
        let t1 = UILabel()
        t1.text = "Bill Categories"
        t1.textAlignment = .center
        t1.textColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        t1.font = .systemFont(ofSize: 14, weight: .medium)
        
        let t2 = UILabel()
        t2.text = "Bills Manager"
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
        
        let selTitle = UILabel()
        selTitle.text = "Choose a category"
        selTitle.textColor = .black
        selTitle.font = .systemFont(ofSize: 16, weight: .medium)
        selTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selTitle)
        
        let gridStack = UIStackView()
        gridStack.axis = .vertical
        gridStack.spacing = 16
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridStack)
        
        let row1 = UIStackView(arrangedSubviews: [
            buildSquareOption(title: "Mobile Recharge", icon: "iphone", active: true),
            buildSquareOption(title: "Data Bundle", icon: "wifi", active: false)
        ])
        let row2 = UIStackView(arrangedSubviews: [
            buildSquareOption(title: "Cable TV", icon: "play.tv", active: false),
            buildSquareOption(title: "Utility/Electricity", icon: "bolt.fill", active: false)
        ])
        let row3 = UIStackView(arrangedSubviews: [
            buildSquareOption(title: "Remita", icon: "r.circle.fill", active: false),
            buildSquareOption(title: "Betting & Gaming", icon: "gamecontroller.fill", active: false)
        ])
        
        [row1, row2, row3].forEach {
            $0.axis = .horizontal; $0.spacing = 16; $0.distribution = .fillEqually
            gridStack.addArrangedSubview($0)
        }
        
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
            
            tabsStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
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
            
            selTitle.topAnchor.constraint(equalTo: tabBaseLine.bottomAnchor, constant: 32),
            selTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            gridStack.topAnchor.constraint(equalTo: selTitle.bottomAnchor, constant: 24),
            gridStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gridStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            row1.heightAnchor.constraint(equalToConstant: 120),
            row2.heightAnchor.constraint(equalToConstant: 120),
            row3.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func buildSquareOption(title: String, icon: String, active: Bool) -> UIView {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 16
        if active {
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0).cgColor
        } else {
            v.layer.shadowColor = UIColor.black.cgColor
            v.layer.shadowOpacity = 0.05
            v.layer.shadowOffset = CGSize(width: 0, height: 4)
            v.layer.shadowRadius = 8
        }
        
        let iconCircle = UIView()
        iconCircle.backgroundColor = UIColor(red: 0.95, green: 0.85, blue: 0.6, alpha: 0.3)
        iconCircle.layer.cornerRadius = 20
        iconCircle.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(iconCircle)
        
        var imgName = icon
        if icon == "r.circle.fill" {
            // fake remita
        }
        let iv = UIImageView(image: UIImage(systemName: imgName))
        iv.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        iv.contentMode = .scaleAspectFit
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
