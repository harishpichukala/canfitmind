import SwiftUI
import SwiftData

@main
struct CanFitMindApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            UserProfile.self,
            DailyProgress.self,
            MealEntry.self,
            WorkoutEntry.self
        ])
    }
}
