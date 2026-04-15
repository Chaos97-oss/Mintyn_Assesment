import UIKit

class TransferViewController: FeatureBaseViewController {
    
    init() {
        super.init(title: "Transfer Funds", icon: "arrow.right.arrow.left")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMockForm()
    }
    
    private func setupMockForm() {
        let card = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        card.layer.cornerRadius = 24
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(card)
        
        let targetLabel = UILabel()
        targetLabel.text = "Recipient Account"
        targetLabel.textColor = .lightGray
        targetLabel.font = .systemFont(ofSize: 14)
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(targetLabel)
        
        let accountField = PaddingTextField()
        accountField.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        accountField.layer.cornerRadius = 12
        accountField.textColor = .white
        accountField.keyboardType = .numberPad
        accountField.placeholder = "0123456789"
        accountField.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(accountField)
        
        let amountLabel = UILabel()
        amountLabel.text = "Amount (₦)"
        amountLabel.textColor = .lightGray
        amountLabel.font = .systemFont(ofSize: 14)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(amountLabel)
        
        let amountField = PaddingTextField()
        amountField.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        amountField.layer.cornerRadius = 12
        amountField.textColor = UIColor(red: 0.4, green: 0.8, blue: 0.4, alpha: 1.0)
        amountField.font = .systemFont(ofSize: 28, weight: .bold)
        amountField.keyboardType = .decimalPad
        amountField.placeholder = "0.00"
        amountField.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(amountField)
        
        let actionBtn = PrimaryButton()
        actionBtn.setTitle("Send Money", for: .normal)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(actionBtn)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            card.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 24),
            card.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -24),
            card.bottomAnchor.constraint(equalTo: actionBtn.bottomAnchor, constant: 24),
            
            targetLabel.topAnchor.constraint(equalTo: card.contentView.topAnchor, constant: 24),
            targetLabel.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            
            accountField.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 8),
            accountField.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            accountField.trailingAnchor.constraint(equalTo: card.contentView.trailingAnchor, constant: -24),
            accountField.heightAnchor.constraint(equalToConstant: 50),
            
            amountLabel.topAnchor.constraint(equalTo: accountField.bottomAnchor, constant: 24),
            amountLabel.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            
            amountField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            amountField.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            amountField.trailingAnchor.constraint(equalTo: card.contentView.trailingAnchor, constant: -24),
            amountField.heightAnchor.constraint(equalToConstant: 70),
            
            actionBtn.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 32),
            actionBtn.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            actionBtn.trailingAnchor.constraint(equalTo: card.contentView.trailingAnchor, constant: -24),
            actionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
