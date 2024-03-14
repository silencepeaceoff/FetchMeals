//
//  InstructionsView.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 09.03.2024.
//

import SwiftUI

struct InstructionsView: View {
  let instructions: String
  @State var showInstruction = false

  var body: some View {
    Section {
      if showInstruction {
        withAnimation(.bouncy) {
          Text(instructions)
            .font(.body)
        }
      }

    } header: {
      HStack {
        Text("Instructions")
          .font(.headline.bold())
        Image(systemName: showInstruction ? "chevron.down" : "chevron.right")
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .foregroundStyle(.tint)
      .padding(.top, 16)
    }
    .onTapGesture {
      self.showInstruction.toggle()
    }
    .padding(.horizontal, 16)
  }
}

#Preview {
  InstructionsView(instructions: "Some instructions…")
}
