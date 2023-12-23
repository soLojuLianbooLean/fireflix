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
        
        
        
        func performRequest(with urlString: String)  {
            if let url = URL(string: urlString)  {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
                  
                        return
                    }
                }
            }
       
        func parseJSON(_ weatherData: Data) -> MovieModel? {
             let decoder = JSONDecoder()
             do {
                 let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                 let id = decodedData.weather[0].id
                 let temp = decodedData.main.temp
                 let name = decodedData.name
                 
                 let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                 return weather
                 
             }
        
    }
        
        struct MovieModel {
            let conditionId: Int
            let cityName: String
            let temperature: Double
            
            var temperatureString: String {
                return String(format: "%.1f", temperature)
            }

}

