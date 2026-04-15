import Foundation

struct Transaction {
    let id: String
    let title: String
    let date: String
    let amount: Double
    let isCredit: Bool
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₦" // Assuming Naira based on typical Mintyn usage
        
        let formatted = formatter.string(from: NSNumber(value: amount)) ?? "₦\(amount)"
        return isCredit ? "+\(formatted)" : "-\(formatted)"
    }
}
