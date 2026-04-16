import UIKit

class CardlessATMViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }
    
    private func setupUI() {
        let backBtn = UIButton(type: .system)
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        backBtn.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        backBtn.layer.cornerRadius = 16
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.addSubview(backBtn)
        
        let titleLabel = UILabel()
        titleLabel.text = "ATM"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStack)
        
        // Block 1
        let aLabel = createSubTitle("Enter Amount")
        let aField = createDarkField("Withdrawal amount should be in multiples of 1000")
        let b1 = UIStackView(arrangedSubviews: [aLabel, aField])
        b1.axis = .vertical; b1.spacing = 8
        contentStack.addArrangedSubview(b1)
        
        // Block 2
        let pLabel = createTitle("Create Paycode PIN")
        let pField = createDarkField("Enter PIN")
        let pSub = createSubLabel("Paycode pin will be used to withdraw at the ATM, 4 digits only.")
        let b2 = UIStackView(arrangedSubviews: [pLabel, pField, pSub])
        b2.axis = .vertical; b2.spacing = 8
        contentStack.addArrangedSubview(b2)
        
        // Block 3
        let cLabel = createTitle("Confirm Paycode PIN")
        let cField = createDarkField("Re-enter PIN")
        let b3 = UIStackView(arrangedSubviews: [cLabel, cField])
        b3.axis = .vertical; b3.spacing = 8
        contentStack.addArrangedSubview(b3)
        
        let cBtn = UIButton(type: .system)
        cBtn.setTitle("Continue", for: .normal)
        cBtn.setTitleColor(.white, for: .normal)
        cBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cBtn.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        cBtn.layer.cornerRadius = 12
        cBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cBtn)
        
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: 32),
            backBtn.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentStack.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 40),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            aField.heightAnchor.constraint(equalToConstant: 60),
            pField.heightAnchor.constraint(equalToConstant: 60),
            cField.heightAnchor.constraint(equalToConstant: 60),
            
            cBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cBtn.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func createTitle(_ text: String) -> UILabel {
        let l = UILabel()
        l.text = text; l.textColor = .white; l.font = .systemFont(ofSize: 16, weight: .medium)
        return l
    }
    
    private func createSubTitle(_ text: String) -> UILabel {
        let l = UILabel()
        l.text = text; l.textColor = .lightGray; l.font = .systemFont(ofSize: 14)
        return l
    }
    
    private func createSubLabel(_ text: String) -> UILabel {
        let l = UILabel()
        l.text = text; l.textColor = .gray; l.font = .systemFont(ofSize: 12)
        return l
    }
    
    private func createDarkField(_ placeholder: String) -> UITextField {
        let t = PaddingTextField()
        t.backgroundColor = UIColor(white: 0.12, alpha: 1.0)
        t.layer.cornerRadius = 12
        t.textColor = .white
        t.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
        return t
    }
    
    @objc private func didTapClose() { dismiss(animated: true) }
}
