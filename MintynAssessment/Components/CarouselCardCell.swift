import UIKit

enum CarouselCardStyle {
    case normal
    case maplerad
    case ncto
    case insurance
}

struct TopCardItem {
    let title: String
    let subtitle: String?
    let icon: String
    let style: CarouselCardStyle
}

class CarouselCardCell: UICollectionViewCell {
    static let identifier = "CarouselCardCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Maplerad specifics
    private let mapleradBlobBase = UIView()
    private let mapleradBlobTop = UIView()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // For text prefix (NCTO)
    private let textIconLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .bold)
        l.textColor = UIColor(red: 0.4, green: 0.8, blue: 0.4, alpha: 1.0)
        l.textAlignment = .center
        l.isHidden = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .white
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.numberOfLines = 1
        l.isHidden = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Main layout stack for title/subtitle
    private lazy var textStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        s.axis = .vertical
        s.spacing = 2
        s.alignment = .leading
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        // Blobs
        mapleradBlobBase.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0) // Deep Blue
        mapleradBlobTop.backgroundColor = UIColor(red: 0.7, green: 0.95, blue: 0.4, alpha: 1.0) // Lime Green
        mapleradBlobBase.layer.cornerRadius = 20
        mapleradBlobTop.layer.cornerRadius = 15
        [mapleradBlobBase, mapleradBlobTop].forEach {
            containerView.addSubview($0)
            $0.isHidden = true
        }
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(textIconLabel)
        containerView.addSubview(textStack)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            textIconLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textIconLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            textStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            textStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mapleradBlobBase.frame = CGRect(x: bounds.width - 25, y: bounds.height - 25, width: 40, height: 40)
        mapleradBlobTop.frame = CGRect(x: bounds.width - 15, y: bounds.height - 15, width: 30, height: 30)
    }
    
    func configure(with item: TopCardItem) {
        titleLabel.text = item.title
        
        if let sub = item.subtitle {
            subtitleLabel.text = sub
            subtitleLabel.isHidden = false
        } else {
            subtitleLabel.isHidden = true
        }
        
        // Reset defaults
        containerView.layer.borderWidth = 0
        iconImageView.isHidden = false
        textIconLabel.isHidden = true
        mapleradBlobBase.isHidden = true
        mapleradBlobTop.isHidden = true
        iconImageView.backgroundColor = .clear
        iconImageView.layer.cornerRadius = 0
        
        switch item.style {
        case .normal:
            iconImageView.image = UIImage(systemName: item.icon)
            iconImageView.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
            textStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
            
        case .maplerad:
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor(red: 0.5, green: 0.8, blue: 0.2, alpha: 1.0).cgColor
            mapleradBlobBase.isHidden = false
            mapleradBlobTop.isHidden = false
            
            // Maplerad icon is square green with M
            iconImageView.image = UIImage(systemName: item.icon)
            iconImageView.tintColor = UIColor(white: 0.1, alpha: 1.0) // Dark Icon Inside
            iconImageView.backgroundColor = UIColor(red: 0.7, green: 0.95, blue: 0.4, alpha: 1.0)
            iconImageView.layer.cornerRadius = 6
            textStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
            
        case .ncto:
            // Text icon
            iconImageView.isHidden = true
            textIconLabel.isHidden = false
            textIconLabel.text = "NCTO"
            NSLayoutConstraint.deactivate(textStack.constraints) // Temporarily decouple to shift text stack correctly
            textStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 64).isActive = true
            
        case .insurance:
            iconImageView.image = UIImage(systemName: item.icon)
            iconImageView.tintColor = UIColor(red: 0.7, green: 0.5, blue: 0.2, alpha: 1.0) // Brown shield
            textStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
        }
    }
    
    // Add interactive animations on touch
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
                self.alpha = self.isHighlighted ? 0.8 : 1.0
            }
        }
    }
}
