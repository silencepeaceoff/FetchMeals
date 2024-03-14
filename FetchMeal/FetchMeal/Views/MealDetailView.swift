//
//  MealDetailView.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

struct MealDetailView: View {
  @EnvironmentObject private var mealViewModel: MealViewModel

  let mealId: String
  let mealName: String

  var body: some View {
    ScrollView {
      if let meal = mealViewModel.mealData {
        if let strMealThumb = meal.strMealThumb {
          ImageView(
            urlString: strMealThumb,
            imageSize: nil
          )
        }

        if let strInstructions = meal.strInstructions {
          if !strInstructions.isEmpty {
            InstructionsView(instructions: strInstructions)
          }
        }

        if meal.ingredients.count > 0 {
          IngredientsView(
            ingredients: meal.ingredients,
            measures: meal.measures
          )
        }

      } else {
        ContentUnavailableView {
          Label("Meal not found", systemImage: "xmark.circle.fill")
        } description: {
          Text("Check your internet connection")
        }
      }
    }
    .navigationTitle(mealName)
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      mealViewModel.loadMeal(id: mealId)
    }
    .onDisappear {
      mealViewModel.cancelTasks()
      mealViewModel.clearMealData()
    }
    .refreshable {
      mealViewModel.loadMeal(id: mealId)
    }

  }
}

#Preview {
  NavigationStack {
    MealDetailView(mealId: "", mealName: "ApplePie")
      .environmentObject(MealViewModel())
  }
}
