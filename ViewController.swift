//
//  ViewController.swift
//  Fireflix
//
//  Created by Julian Reefer on 12/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nowShowing: UIImageView!
    
    @IBOutlet weak var searchTextField: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    
    func textFieldShouldReturn(_  textField: UISearchBar)  -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    struct Movies  {
        let movieURL = "https://7c5l2752slr66y56baikmdzahi0tdlxj.lambda-url.us-east-1.on.aws/"
        
        func fetchMovie(movieName: String) {
            let urlString = "\(movieURL)&q=\(movieName)"
            performRequest(with: urlString) }
        
        
        func performRequest(with urlString: String)  {
            if let url = URL(string: urlString)  {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
                    
                    return
                }
                
            }
        }
        
        func parseJSON(_ movieData: Data) -> MovieModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData =
                try JSONDecoder().decode(MovieData.self, from: movieData)
                let genre = decodedData.genre
                let name = decodedData.name
                
                return   MovieModel.init(conditionId: <#T##Int#>, movieName: <#T##String#>)
                
                catch let error {
                    
                    self.text = error.localizedDescription
                    return "Movie could not be found"
                    
                    return nil}
                
                
            }
            
            
        } }
        
        struct MovieModel {
            let conditionId: Int
            let movieName: String
            
        }
        
    }

