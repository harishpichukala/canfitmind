import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DailyProgress.date, order: .reverse) var progressList: [DailyProgress]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("📅 Today's Progress")
                    .font(.title)
                    .bold()

                if let today = progressList.first(where: { Calendar.current.isDateInToday($0.date) }) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weight: \(today.weight, specifier: "%.1f") kg")
                        Text("Steps: \(today.steps)")
                        Text("Sleep: \(today.sleepHours, specifier: "%.1f") hrs")
                    }
                } else {
                    Text("No data for today yet.")
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: addSampleProgress) {
                    Text("➕ Add Sample Entry")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("CanFitMind")
        }
    }

    func addSampleProgress() {
        let sample = DailyProgress(date: Date(), weight: 100.2, steps: 8000, sleepHours: 6.5)
        context.insert(sample)
    }
}
