//
//  IngredientsVIew.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 09.03.2024.
//

import SwiftUI

struct IngredientsView: View {
  @State var showIngredients = false

  let ingredients: [String?]
  let measures: [String?]

  var body: some View {
    Section {
      if showIngredients {
        withAnimation(.bouncy) {

          ForEach(0 ..< ingredients.count, id: \.self) { index in
            if let ingredient = ingredients[index],
               let measure = measures[index] {

              if !ingredient.isEmpty && !measure.isEmpty {
                HStack {
                  Text("\(ingredient):")
                    .font(.body.bold())
                  Text(measure)
                    .font(.body.italic())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              }

            }
          }

        }
      }
    } header: {
      HStack {
        Text("Ingredients")
          .font(.headline.bold())
        Image(systemName: showIngredients ? "chevron.down" : "chevron.right")
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .foregroundStyle(.tint)
      .padding(.top, 16)

    }
    .onTapGesture {
      self.showIngredients.toggle()
    }
    .padding(.horizontal, 16)
  }

}

#Preview {
  IngredientsView(ingredients: ["Apple, Banana"], measures: ["1", "2"])
}
