import SwiftUI
import SwiftData

struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context

    @State private var mealType = "Lunch"
    @State private var calories = ""
    @State private var notes = ""

    let mealOptions = ["Breakfast", "Lunch", "Dinner", "Snack"]

    var body: some View {
        NavigationView {
            Form {
                Picker("Meal Type", selection: $mealType) {
                    ForEach(mealOptions, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Calories", text: $calories)
                    .keyboardType(.numberPad)

                TextField("Notes", text: $notes)
            }
            .navigationTitle("Add Meal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveMeal()
                    }
                    .disabled(calories.isEmpty)
                }
            }
        }
    }

    func saveMeal() {
        let meal = MealEntry(
            date: Date(),
            mealType: mealType,
            calories: Int(calories) ?? 0,
            notes: notes.isEmpty ? nil : notes
        )
        context.insert(meal)
        dismiss()
    }
}
