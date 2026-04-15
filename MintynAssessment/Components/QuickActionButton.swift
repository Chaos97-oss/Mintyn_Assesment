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
        backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0) // Glassmorphic card
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.05).cgColor
        
        addSubview(iconImageView)
        addSubview(titleTextLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            titleTextLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12),
            titleTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            titleTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
    
    // Add interactive animations mapping state changes
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.94, y: 0.94) : .identity
                self.alpha = self.isHighlighted ? 0.7 : 1.0
            }
        }
    }
}
