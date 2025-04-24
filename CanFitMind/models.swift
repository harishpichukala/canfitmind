import Foundation
import SwiftData

@Model
class UserProfile {
    var name: String
    var age: Int
    var weight: Double
    var targetWeight: Double
    var activityLevel: String

    init(name: String, age: Int, weight: Double, targetWeight: Double, activityLevel: String) {
        self.name = name
        self.age = age
        self.weight = weight
        self.targetWeight = targetWeight
        self.activityLevel = activityLevel
    }
}

@Model
class DailyProgress {
    var date: Date
    var weight: Double
    var steps: Int
    var sleepHours: Double

    init(date: Date, weight: Double, steps: Int, sleepHours: Double) {
        self.date = date
        self.weight = weight
        self.steps = steps
        self.sleepHours = sleepHours
    }
}

@Model
class MealEntry {
    var date: Date
    var mealType: String // Breakfast, Lunch, Dinner
    var calories: Int
    var notes: String?

    init(date: Date, mealType: String, calories: Int, notes: String?) {
        self.date = date
        self.mealType = mealType
        self.calories = calories
        self.notes = notes
    }
}

@Model
class WorkoutEntry {
    var date: Date
    var workoutType: String // Cardio, Strength, Swimming
    var duration: Double // in minutes

    init(date: Date, workoutType: String, duration: Double) {
        self.date = date
        self.workoutType = workoutType
        self.duration = duration
    }
}
