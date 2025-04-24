import SwiftUI
import SwiftData

struct AICoachView: View {
    @Query(sort: \DailyProgress.date, order: .reverse) var progressList: [DailyProgress]
    @Query(sort: \WorkoutEntry.date, order: .reverse) var workouts: [WorkoutEntry]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("🧠 Your AI Coach")
                    .font(.largeTitle)
                    .bold()

                Text("👋 Hi Harish, here's what I noticed today:")
                    .font(.headline)

                if let today = progressList.first(where: { Calendar.current.isDateInToday($0.date) }) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("📉 Weight: \(today.weight, specifier: "%.1f") kg")
                        Text("🚶 Steps: \(today.steps)")
                        Text("😴 Sleep: \(today.sleepHours, specifier: "%.1f") hrs")
                        Divider()

                        Text(generateAdvice(from: today))
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                } else {
                    Text("No data found for today. Add your progress first!")
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("AI Coach")
        }
    }

    func generateAdvice(from data: DailyProgress) -> String {
        var advice = ""

        if data.steps < 5000 {
            advice += "🦶 Try to walk at least 5,000 steps. "
        } else {
            advice += "🎉 Great job staying active! "
        }

        if data.sleepHours < 6 {
            advice += "💤 You need more rest tonight. "
        } else {
            advice += "😴 Sleep looks good. "
        }

        if data.weight < 101 {
            advice += "🔥 You're making great progress!"
        } else {
            advice += "📉 Keep pushing — you're close to your goal!"
        }

        return advice
    }
}
