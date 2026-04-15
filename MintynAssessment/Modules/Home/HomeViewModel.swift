import Foundation

class HomeViewModel {
    // MARK: - Outputs
    var onDataUpdated: (() -> Void)?
    
    // MARK: - State
    private(set) var transactions: [Transaction] = []
    
    var balance: String {
        return "₦1,450,000.00" // Mock balance
    }
    
    // MARK: - Data Loading
    func loadData() {
        // Mock data
        transactions = [
            Transaction(id: "1", title: "Transfer to John Doe", date: "Today, 10:30 AM", amount: 25000, isCredit: false),
            Transaction(id: "2", title: "Salary Deposit", date: "Yesterday, 08:00 AM", amount: 450000, isCredit: true),
            Transaction(id: "3", title: "Netflix Subscription", date: "Oct 12, 09:00 PM", amount: 4500, isCredit: false),
            Transaction(id: "4", title: "Grocery Shopping", date: "Oct 10, 02:15 PM", amount: 15600, isCredit: false),
            Transaction(id: "5", title: "Airtime Recharge", date: "Oct 09, 11:45 AM", amount: 2000, isCredit: false)
        ]
        
        onDataUpdated?()
    }
}
