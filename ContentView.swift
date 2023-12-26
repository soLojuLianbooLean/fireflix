//
//  ContentView.swift
//  Fireflix
//
//  Created by Julian Reefer on 12/24/23.
//

import SwiftUI



struct Movies: Hashable, Decodable {
    let image_name: String
    let image: String
    let image_genre: String
}
@main
class Appdelegate: UIResponder, UIApplicationDelegate {
}

class ViewModel: ObservableObject {
    @Published var movies: [Movies] = []

    func fetch() {
        guard let url = URL(string: "https://7c5l2752slr66y56baikmdzahi0tdlxj.lambda-url.us-east-1.on.aws/") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let movies = try JSONDecoder().decode([Movies].self, from: data)
                DispatchQueue.main.async {
                    self?.movies = movies
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
}

// Code for image
struct URLImage: View {
    let urlString: String

    @State private var uiImage: UIImage? = nil

    
    func fromBase64(word: String) -> String {
        let base64Decoded = Data(base64Encoded: word)!
        let decodedString = String(data: base64Decoded, encoding: .utf8)!
        return decodedString
    }

    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        } else {
            Image(systemName: "movie")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
        
        
    }

    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching image data: \(error)")
                return
            }

            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = uiImage
                }
            } else {
                print("Failed to create UIImage from data")
            }
        }

        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies, id: \.self) { movie in
                    HStack {
                        URLImage(urlString: movie.image)
                            .frame(width: 130, height: 70)

                        Text(movie.image_name)
                            .bold()
                        Text(movie.image_genre)
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Fireflix")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}
