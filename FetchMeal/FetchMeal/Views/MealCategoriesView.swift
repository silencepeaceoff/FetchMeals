//
//  MealCategoriesView.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 09.03.2024.
//

import SwiftUI

enum AnimationState: CaseIterable {
  case one, two, three
  
  mutating func next() {
    switch self {
    case .one:
      self = .two
    case .two:
      self = .three
    case .three:
      self = .one
    }
  }
  
  var columns: [GridItem] {
    switch self {
    case .one:
      return [GridItem(.flexible())]
    case .two:
      return [GridItem(.flexible()), GridItem(.flexible())]
    case .three:
      return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    }
  }
}

struct MealCategoriesView: View {
  @Environment(\.colorScheme) private var colorScheme
  
  @StateObject var mealViewModel = MealViewModel()
  
  @State var animationState: AnimationState = .one
  
  var body: some View {
    ScrollView {
      if !mealViewModel.categoriesArray.categories.isEmpty {
        
        LazyVGrid(columns: animationState.columns, spacing: 20) {
          ForEach(mealViewModel.categoriesArray.categories, id: \.self) { category in
            
            NavigationLink(destination: {
              MealListView(categoryName: category.strCategory)
                .environmentObject(mealViewModel)
              
            }) {
              VStack {
                ImageView(urlString: category.strCategoryThumb, imageSize: nil)
                
                Text(category.strCategory)
                  .font(.headline.bold())
                  .foregroundStyle(colorScheme == .dark ? .white : .black)
              }
            }
            
          }
        }
        
      } else {
        ContentUnavailableView {
          Label("There is no categories", systemImage: "xmark.circle.fill")
        } description: {
          Text("Check your internet connection")
        }
      }
    }
    .navigationTitle("Categories")
    .onAppear {
      mealViewModel.loadCategories()
    }
    .onDisappear {
      mealViewModel.cancelTasks()
    }
    .refreshable {
      mealViewModel.loadCategories()
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        RectAnimateIcon(animationState: $animationState)
      }
    }
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
  }
}

#Preview {
  NavigationStack {
    MealCategoriesView()
  }
}
