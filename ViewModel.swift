//
//  ViewModel.swift
//  Fireflix
//
//  Created by Julian Reefer on 12/25/23.
//

import Foundation
import SwiftUI

struct Movies: Hashable, Codable {
    let image_name: String
    let image: String
    let image_genre: String
}

class ViewModel: ObservableObject {
    
    @Published var movies: [Movies]  = []
    
    func fetch()  {
        guard let url = URL(string: "https://7c5l2752slr66y56baikmdzahi0tdlxj.lambda-url.us-east-1.on.aws/") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self]
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
        
            do {
                let movies = try JSONDecoder().decode([Movies].self, from: data)
                DispatchQueue.main.async {
                    self?.movies = movies
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
