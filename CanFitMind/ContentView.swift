import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            MealPlannerView()
                .tabItem {
                    Label("Meals", systemImage: "fork.knife")
                }

            WorkoutTrackerView()
                .tabItem {
                    Label("Workouts", systemImage: "figure.strengthtraining.traditional")
                }

            AICoachView()
                .tabItem {
                    Label("Coach", systemImage: "brain.head.profile")
                }
        }
    }
}
