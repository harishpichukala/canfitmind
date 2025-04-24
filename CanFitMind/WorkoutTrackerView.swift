import SwiftUI
import SwiftData

struct WorkoutTrackerView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \WorkoutEntry.date, order: .reverse) private var workouts: [WorkoutEntry]
    @State private var showAddWorkout = false

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts.filter { Calendar.current.isDateInToday($0.date) }) { workout in
                    VStack(alignment: .leading) {
                        Text(workout.workoutType)
                            .font(.headline)
                        Text("Duration: \(workout.duration, specifier: "%.0f") mins")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteWorkout)
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddWorkout = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddWorkout) {
                AddWorkoutView()
            }
        }
    }

    func deleteWorkout(at offsets: IndexSet) {
        for index in offsets {
            let todayWorkouts = workouts.filter { Calendar.current.isDateInToday($0.date) }
            let workoutToDelete = todayWorkouts[index]
            context.delete(workoutToDelete)
        }
    }
}
