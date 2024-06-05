import SwiftUI
import FirebaseCore

@main
struct SerenityJournalApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

