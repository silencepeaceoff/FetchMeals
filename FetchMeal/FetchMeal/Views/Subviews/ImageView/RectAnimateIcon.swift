//
//  RectAnimateIcon.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 14.03.2024.
//

import SwiftUI

struct RectAnimateIcon: View {
  @Environment(\.colorScheme) private var colorScheme

  @Binding var animationState: AnimationState

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 3, style: .circular)
        .frame(width: 30, height: 20)
        .foregroundStyle(colorScheme == .dark ? .white : .black)

      Rectangle()
        .frame(width: 30, height: 2)

      Rectangle()
        .frame(width: 2, height: 20)
        .offset(y: animationState == .two ? 0 : 20)

      Rectangle()
        .frame(width: 2, height: 20)
        .offset(x: 5, y: animationState == .three ? 0 : -20)
      Rectangle()
        .frame(width: 2, height: 20)
        .offset(x: -5, y: animationState == .three ? 0 : 20)
    }
    .foregroundStyle(colorScheme == .dark ? .black : .white)
    .clipped()
    .mask({
      RoundedRectangle(cornerRadius: 5, style: .continuous)
    })
    .onTapGesture {
      withAnimation {
        animationState.next()
      }
    }
  }
}

#Preview {
  RectAnimateIcon(animationState: .constant(.one))
}
