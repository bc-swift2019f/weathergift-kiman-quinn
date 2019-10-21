//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kim-An Quinn on 10/18/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation{
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    
    func getWeather(completed: @escaping () -> ()){
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double{
                    let roundedTemp = String(format:"%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                }
                else{
                    print("Could not return a temperature ")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}


