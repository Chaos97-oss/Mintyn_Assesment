import UIKit

class ProductUpdatesViewController: FeatureBaseViewController {
    init() { super.init(title: "Product Updates", icon: "bell.badge.fill") }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func viewDidLoad() {
        super.viewDidLoad()
        let desc = UILabel()
        desc.text = "All new product features will appear here."
        desc.textColor = .lightGray
        desc.textAlignment = .center
        desc.font = .systemFont(ofSize: 16)
        desc.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(desc)
        NSLayoutConstraint.activate([
            desc.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor),
            desc.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 100)
        ])
    }
}
