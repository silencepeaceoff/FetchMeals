//
//  FetchService.swift
//  FetchMeal
//
//  Created by Dmitrii Tikhomirov on 06.03.2024.
//

import SwiftUI

final class FetchService {
  
  func fetchData<T: Decodable>(for: T.Type, from url: URL) async throws -> T {
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard !data.isEmpty else {
      throw NetworkError.invalidData
    }
    
    do {
      return try JSONDecoder().decode(
        T.self, 
        from: try mapResponse(response: (data: data, response: response))
      )
    } catch {
      throw error
    }
  }
  
}
