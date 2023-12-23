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
                try decoder.decode(MovieData.self, from: movieData)
                //JSONDecoder().decode(MovieData.self, from: movieData)
                
                return   MovieModel(genre: <#T##String#>, movieName: <#T##String#>)
            }
                catch {
                    print(error)
                    
                }
                
                
            }
            
            
        } }
        
     
        
    

