import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    @State private var workoutType = "Swimming"
    @State private var duration = ""

    let workoutOptions = ["Swimming", "Cycling", "Running", "Gym", "Yoga"]

    var body: some View {
        NavigationView {
            Form {
                Picker("Workout Type", selection: $workoutType) {
                    ForEach(workoutOptions, id: \.self) { type in
                        Text(type)
                    }
                }

                TextField("Duration (mins)", text: $duration)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add Workout")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveWorkout()
                    }
                    .disabled(duration.isEmpty)
                }
            }
        }
    }

    func saveWorkout() {
        let newWorkout = WorkoutEntry(
            date: Date(),
            workoutType: workoutType,
            duration: Double(duration) ?? 0
        )
        context.insert(newWorkout)
        dismiss()
    }
}
