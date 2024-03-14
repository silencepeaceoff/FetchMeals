//
//  ContentView.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

struct MealListView: View {
  @EnvironmentObject private var mealViewModel: MealViewModel
  
  let categoryName: String
  
  var body: some View {
    NavigationStack {
      
      List {
        ForEach(mealViewModel.filterMeals, id: \.self) { meal in
          NavigationLink {
            MealDetailView(mealId: meal.idMeal, mealName: meal.strMeal)
              .environmentObject(mealViewModel)
            
          } label: {
            MealRowView(meal: meal)
              .foregroundStyle(.primary)
          }
        }
        
      }
      .navigationTitle(categoryName)
      .alert(
        "Error",
        isPresented: $mealViewModel.showAlert,
        actions: {
          Button("Ok") {
            
          }
        }, message: {
          Text(mealViewModel.alertMessage)
        }
      )
      .overlay {
        if mealViewModel.mealsArray.isEmpty {
          ContentUnavailableView {
            Label("There is no \(categoryName)", systemImage: "xmark.circle.fill")
          } description: {
            Text("Check your internet connection")
          }
        } else if mealViewModel.filterMeals.isEmpty {
          ContentUnavailableView.search(text: mealViewModel.searchTerm)
        }
      }
      .searchable(text: $mealViewModel.searchTerm, prompt: "Search some \(categoryName) meal…")
      .onAppear {
        mealViewModel.loadCategory(name: categoryName)
      }
      .onDisappear {
        mealViewModel.cancelTasks()
      }
      .refreshable {
        mealViewModel.loadCategory(name: categoryName)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            mealViewModel.sortAlpfabetically.toggle()
          } label: {
            Image(systemName: "arrow.up.arrow.down")
              .resizable()
              .scaledToFit()
              .frame(width: 20)
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    MealListView(categoryName: "Dessert")
      .environmentObject(MealViewModel())
  }
}
