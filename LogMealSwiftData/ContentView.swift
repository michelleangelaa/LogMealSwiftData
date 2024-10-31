//
//  ContentView.swift
//  LogMealSwiftData
//
//  Created by Michelle Angela Aryanto on 30/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var isShowingItemSheet = false
    @Query(sort: \Meal.date)
    var meals: [Meal] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(meals) { meal in
                    MealCell(meal: meal)
                }
            }
            .navigationBarTitle("Log Meal")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                LogMealSheet()
            }
            .toolbar {
                if !meals.isEmpty {
                    Button("Log meal", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if meals.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No logged meal", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("start logging meal")
                    }, actions: {
                        Button("log meal") { isShowingItemSheet = true }
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct MealCell: View {
    let meal: Meal

    var body: some View {
        HStack {
            Text(meal.date, format: .dateTime)
            Text(meal.ingredient)
            Spacer()
            Text(String(meal.servingQty))
            Text(meal.servingUnit)
            Spacer()
            Text(meal.reaction)
            Text(meal.notes)
        }
    }
}

struct LogMealSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var servingQty: Double = 1.0
    @State private var servingUnit: String = "g"
    @State private var reaction: String = "Liked It"
    @State private var notes: String = "describe the meal"

    var units = ["spoon", "cup"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Ingredient Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Qty", value: $servingQty, format: .number)
                    .keyboardType(.decimalPad)
                Picker("Unit", selection: $servingUnit) {
                    ForEach(units, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .pickerStyle(.segmented)
                TextField("Reaction", text: $reaction)
                TextField("Notes", text: $notes)
            }
            .navigationTitle("Rate your meal")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Back") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let meal = Meal(ingredient: name, date: date, servingQty: servingQty, servingUnit: servingUnit, reaction: reaction, notes: notes)
                        context.insert(meal)
                        dismiss()
                    }
                }
            }
        }
    }
}
