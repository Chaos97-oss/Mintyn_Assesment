import UIKit

class QuickActionButton: UIButton {
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        setupUI()
        titleTextLabel.text = title
        iconImageView.image = UIImage(systemName: iconName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 0.15, alpha: 1.0) // Dark card
        layer.cornerRadius = 16
        
        addSubview(iconImageView)
        addSubview(titleTextLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleTextLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            titleTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}
