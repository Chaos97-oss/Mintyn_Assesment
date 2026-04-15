import UIKit

class PaddingTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        textColor = .white
        layer.cornerRadius = 8
        autocorrectionType = .no
        autocapitalizationType = .none
        
        let placeholderAttr = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        attributedPlaceholder = NSAttributedString(string: " ", attributes: placeholderAttr)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
