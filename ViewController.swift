//
//  ViewController.swift
//  Fireflix
//
//  Created by Julian Reefer on 12/21/23.
//
import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @main
    struct YourApp {
        static func main() {
            // Your setup code and application entry point
        }
    }


    @IBOutlet weak var nowShowing: UIImageView!
    @IBOutlet weak var searchTextField: UISearchBar!

    struct Movies {
        let movieURL = "https://7c5l2752slr66y56baikmdzahi0tdlxj.lambda-url.us-east-1.on.aws/"

        func fetchMovie(movieName: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
            let movieURL = URL(string: "https://7c5l2752slr66y56baikmdzahi0tdlxj.lambda-url.us-east-1.on.aws/")
            
            
          
        }

        func performRequest(with urlString: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
            if let url = URL(string: urlString) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                

                    if let data = data {
                        if let movieModel = parseJSON(data) {
                            completion(.success(movieModel))
                        } else {
                            let parsingError = NSError(domain: "ParsingError", code: 1, userInfo: nil)
                            completion(.failure(parsingError))
                        }
                    }
                }
                task.resume()
            }
        }

        func parseJSON(_ movieData: Data) -> MovieModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(MovieData.self, from: movieData)
                return MovieModel(image_genre: decodedData.image_genre, image_name: decodedData.image_name, image_image: decodedData.image_image)
            } catch {
                print(error)
          
                
                return nil
                
               
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)

        let movies = Movies()
        movies.fetchMovie(movieName: "") { result in
            switch result {
            case .success(let movieModel):
                print("Movie fetched successfully: \(movieModel)")
                // Handle the movie model as needed
            case .failure(let error):
                print("Error fetching movie: \(error)")
                // Handle the error
                exit(EXIT_FAILURE)
           
            }
        }
    }
    
    
}
