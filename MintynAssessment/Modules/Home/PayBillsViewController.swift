import UIKit

class PayBillsViewController: FeatureBaseViewController {
    
    init() {
        super.init(title: "Pay Bills", icon: "doc.text")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(stack)
        
        let mockCategories = ["Electricity", "Internet", "Water", "TV Subscription"]
        
        for cat in mockCategories {
            let billBtn = PrimaryButton()
            billBtn.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
            billBtn.setTitleColor(.white, for: .normal)
            billBtn.setTitle(cat, for: .normal)
            stack.addArrangedSubview(billBtn)
            billBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            stack.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -24)
        ])
    }
}
