//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kim-An Quinn on 10/18/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import Foundation
import Alamofire


class WeatherLocation{
    var name = ""
    var coordinates = ""
    
    func getWeather(){
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            print(response)
        }
    }
}


