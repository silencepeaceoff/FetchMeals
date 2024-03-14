//
//  ImageView.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

struct ImageView: View {
  let urlString: String
  let imageSize: CGFloat?
  
  var body: some View {
    
    if let url = URL(string: urlString) {
      
      if let imageSize {
        getImage(url: url)
          .clipShape(.rect(cornerRadius: imageSize * 0.1))
          .frame(width: imageSize, height: imageSize)
        
      } else {
        getImage(url: url)
      }
      
    } else {
      Image(systemName: "photo.artframe")
        .resizable()
        .scaledToFit()
        .clipShape(.rect(cornerRadius: (imageSize ?? 60.0) * 0.1))
        .frame(width: imageSize, height: imageSize)
    }
    
  }
  
  private func getImage(url: URL) -> some View {
    CachingAsyncImage(
      url: url, 
      transaction: Transaction(animation: .easeIn(duration: 0.3))
    ) { phase in
      
      if let image = phase.image {
        image
          .resizable()
          .scaledToFit()
        
      } else if phase.error != nil {
        Image(systemName: "questionmark.diamond")
          .resizable()
          .scaledToFit()
          .frame(width: 120, height: 120)
          .foregroundStyle(.secondary)
          .padding()
        
      } else {
        ProgressView()
      }
      
    }
  }
  
}

#Preview {
  ImageView(urlString: "", imageSize: 60.0)
}
