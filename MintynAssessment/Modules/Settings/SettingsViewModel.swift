import Foundation

enum SettingsSection: Int, CaseIterable {
    case system
    case legal
    case logout
    
    var title: String {
        switch self {
        case .system: return "System"
        case .legal: return "Legal"
        case .logout: return "Account"
        }
    }
    
    var items: [String] {
        switch self {
        case .system: return ["Appearance", "Notifications", "Security"]
        case .legal: return ["Terms of Service", "Privacy Policy"]
        case .logout: return ["Log out"]
        }
    }
}

class SettingsViewModel {
    
    var onLogout: (() -> Void)?
    
    func handleSelection(at indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        if section == .logout {
            // Perform mocked logout
            // (In a real app, clear keychain/UserDefaults here)
            onLogout?()
        }
        // Handle other actions here...
    }
}
