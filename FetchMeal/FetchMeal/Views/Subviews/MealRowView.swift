//
//  MealRowView.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

struct MealRowView: View {
  let meal: Meals

  var body: some View {

    HStack {
      ImageView(urlString: meal.strMealThumb, imageSize: 60.0)
      Text(meal.strMeal)
    }

  }
}

#Preview {
  MealRowView(meal: .init(strMeal: "Oil", strMealThumb: "https", idMeal: "1"))
}
