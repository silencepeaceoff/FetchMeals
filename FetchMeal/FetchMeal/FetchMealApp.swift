//
//  FetchMealApp.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

@main
struct FetchMealApp: App {
  var body: some Scene {
    WindowGroup {

      NavigationStack {
        MealCategoriesView()
      }

    }
  }
}
