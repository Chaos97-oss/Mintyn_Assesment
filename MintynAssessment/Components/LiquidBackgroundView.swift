import UIKit

class LiquidBackgroundView: UIView {
    private let orb1 = UIView()
    private let orb2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLiquidGlassBackground()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLiquidGlassBackground()
    }
    
    // Abstracted liquid glass effect
    private func setupLiquidGlassBackground() {
        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1.0)
        clipsToBounds = true
        
        orb1.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 0.4)
        orb1.layer.cornerRadius = 100
        addSubview(orb1)
        
        orb2.backgroundColor = UIColor(red: 0.3, green: 0.1, blue: 0.5, alpha: 0.4)
        orb2.layer.cornerRadius = 150
        addSubview(orb2)
        
        let blurOverlay = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurOverlay.frame = bounds
        blurOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurOverlay)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure static start positions loosely proportional to the view before animations trigger
        if orb1.frame.width == 0 {
            orb1.frame = CGRect(x: -50, y: 100, width: 200, height: 200)
            orb2.frame = CGRect(x: bounds.width - 150, y: bounds.height / 2, width: 300, height: 300)
            animateLiquidOrbs()
        }
    }
    
    private func animateLiquidOrbs() {
        UIView.animate(withDuration: 8.0, delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
            self.orb1.transform = CGAffineTransform(translationX: 100, y: 50).scaledBy(x: 1.2, y: 1.2)
            self.orb2.transform = CGAffineTransform(translationX: -80, y: -100).scaledBy(x: 0.8, y: 0.8)
        })
    }
}
