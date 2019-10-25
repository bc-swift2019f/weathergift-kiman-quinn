//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Kim-An Quinn on 10/25/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String){
        self.name = name
        self.coordinates = coordinates
    }
    
}
