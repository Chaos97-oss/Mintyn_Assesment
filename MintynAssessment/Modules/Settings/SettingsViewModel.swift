import Foundation

struct SettingsOption {
    let title: String
    let iconName: String
}

struct SettingsSectionModel {
    let title: String
    let options: [SettingsOption]
}

class SettingsViewModel {
    let sections: [SettingsSectionModel] = [
        SettingsSectionModel(title: "Profile", options: [
            SettingsOption(title: "Personal Information", iconName: "person.circle"),
            SettingsOption(title: "Payment Limits", iconName: "chart.bar"),
            SettingsOption(title: "Security", iconName: "lock.shield")
        ]),
        SettingsSectionModel(title: "Preferences", options: [
            SettingsOption(title: "Notifications", iconName: "bell"),
            SettingsOption(title: "Appearance", iconName: "paintbrush"),
            SettingsOption(title: "Fingerprint / Face ID", iconName: "faceid")
        ]),
        SettingsSectionModel(title: "System", options: [
            SettingsOption(title: "Help & Support", iconName: "questionmark.circle"),
            SettingsOption(title: "Logout", iconName: "arrow.right.square")
        ])
    ]
}
