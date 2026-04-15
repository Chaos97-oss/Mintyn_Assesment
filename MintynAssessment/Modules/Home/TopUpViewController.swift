import UIKit

class TopUpViewController: FeatureBaseViewController {
    
    init() {
        super.init(title: "Airtime & Data", icon: "iphone")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let card = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        card.layer.cornerRadius = 24
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 0.3).cgColor
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(card)
        
        let numberLabel = UILabel()
        numberLabel.text = "Phone Number"
        numberLabel.textColor = .lightGray
        numberLabel.font = .systemFont(ofSize: 14)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(numberLabel)
        
        let numField = PhoneNumberField()
        numField.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(numField)
        
        let actionBtn = PrimaryButton()
        actionBtn.setTitle("Proceed", for: .normal)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        card.contentView.addSubview(actionBtn)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            card.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 24),
            card.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -24),
            card.bottomAnchor.constraint(equalTo: actionBtn.bottomAnchor, constant: 24),
            
            numberLabel.topAnchor.constraint(equalTo: card.contentView.topAnchor, constant: 24),
            numberLabel.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            
            numField.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            numField.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            numField.trailingAnchor.constraint(equalTo: card.contentView.trailingAnchor, constant: -24),
            numField.heightAnchor.constraint(equalToConstant: 50),
            
            actionBtn.topAnchor.constraint(equalTo: numField.bottomAnchor, constant: 32),
            actionBtn.leadingAnchor.constraint(equalTo: card.contentView.leadingAnchor, constant: 24),
            actionBtn.trailingAnchor.constraint(equalTo: card.contentView.trailingAnchor, constant: -24),
            actionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
