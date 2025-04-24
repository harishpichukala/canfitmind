import SwiftUI
import SwiftData

struct MealPlannerView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \MealEntry.date, order: .reverse) private var meals: [MealEntry]
    @State private var showAddMeal = false

    var body: some View {
        NavigationView {
            List {
                ForEach(meals.filter { Calendar.current.isDateInToday($0.date) }) { meal in
                    VStack(alignment: .leading) {
                        Text(meal.mealType)
                            .font(.headline)
                        Text("Calories: \(meal.calories)")
                            .font(.subheadline)
                        if let notes = meal.notes {
                            Text("Note: \(notes)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteMeal)
            }
            .navigationTitle("Meal Planner")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddMeal.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddMeal) {
                AddMealView()
            }
        }
    }

    private func deleteMeal(at offsets: IndexSet) {
        for index in offsets {
            let todayMeals = meals.filter { Calendar.current.isDateInToday($0.date) }
            let mealToDelete = todayMeals[index]
            context.delete(mealToDelete)
        }
    }
}
