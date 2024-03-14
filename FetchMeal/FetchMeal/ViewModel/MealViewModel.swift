//
//  MealViewModel.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

@MainActor
final class MealViewModel: ObservableObject {
  @Published private(set) var categoriesArray = MealCategories(categories: [])
  @Published private(set) var mealsArray = MealsData(meals: [])
  @Published private(set) var mealData: MealData?

  @Published var showAlert = false
  @Published private(set) var alertMessage = ""

  @Published var searchTerm: String = ""
  @Published var sortAlpfabetically = true

  private let mainUrl = "https://www.themealdb.com/api/json/v1/1/"

  var sortedMealsArray: [Meals] {
    if sortAlpfabetically {
      return mealsArray.sorted { $0.strMeal < $1.strMeal }
    } else {
      return mealsArray.sorted { $0.strMeal > $1.strMeal }
    }
  }

  var filterMeals: [Meals] {
    guard !searchTerm.isEmpty else { return sortedMealsArray }

    return sortedMealsArray.filter {
      $0.strMeal.localizedCaseInsensitiveContains(searchTerm)
    }
  }

  let loader = FetchService()

  private var tasks: [Task<Void, Never>] = []

  func cancelTasks() {
    tasks.forEach { $0.cancel() }
    tasks = []
  }

  func clearMealsArray() {
    mealsArray = MealsData(meals: [])
  }

  func clearMealData() {
    mealData = nil
  }

  private func makeURL(endpoint: String) -> URL? {
    URL(string: "\(mainUrl)\(endpoint)")
  }

  private func load<T: Decodable>(endpoint: String, modelType: T.Type) {
    let task = Task {
      do {
        guard let url = makeURL(endpoint: endpoint) else { return }
        let data = try await loader.fetchData(for: modelType, from: url)

        if let categories = data as? MealCategories {
          self.categoriesArray = categories
        } else if let mealsData = data as? MealsData {
          self.mealsArray = mealsData
        } else if let meal = data as? Meal {
          self.mealData = meal.meals?.first
        }

      } catch {
        self.handleError(error)
      }
    }

    tasks.append(task)
  }

  func loadCategories() {
    load(endpoint: "categories.php", modelType: MealCategories.self)
  }

  func loadCategory(name: String) {
    load(endpoint: "filter.php?c=\(name)", modelType: MealsData.self)
  }

  func loadMealByName(name: String) {
    load(endpoint: "search.php?s=\(name)", modelType: Meal.self)
  }

  func loadMeal(id: String) {
    load(endpoint: "lookup.php?i=\(id)", modelType: Meal.self)
  }

  func handleError(_ error: Error) {
    showAlert = true
    alertMessage = error.localizedDescription
  }

}
