//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Kim-An Quinn on 10/18/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherDetail: WeatherLocation{
    
    struct HourlyForcast{
        var hourlyTime: Double
        var hourlyTemperature: Double
        var hourlyPrecipProb: Double
        var hourlyIcon: String
    }
    
    struct DailyForcast{
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailySummary: String
        var dailyIcon: String
    }
    

    var currentTemp = "--"
    var currentSummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    var hourlyForcastArray = [HourlyForcast]()
    var dailyForcastArray = [DailyForcast]()
    
    
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
                if let summary = json["daily"]["summary"].string{
                    self.currentSummary = summary
                }else{
                    print("Could not return a summary")
                }
                if let icon = json["currently"]["icon"].string{
                    self.currentIcon = icon
                }else{
                    print("Could not return a icon")
                }
                if let timeZone = json["timezone"].string{
                    self.timeZone = timeZone
                }else{
                    print("Could not return a timeZone")
                }
                if let time = json["currently"]["time"].double{
                    self.currentTime = time
                }else{
                    print("Could not return a time")
                }
                
                let dailyDataArray = json["daily"]["data"]
                self.dailyForcastArray = []
                let days = min(7, dailyDataArray.count-1)
                for day in 1...days{
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForcast = DailyForcast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailySummary: dailySummary, dailyIcon: icon)
                    self.dailyForcastArray.append(newDailyForcast)
                }
                
                let hourlyDataArray = json["hourly"]["data"]
                self.hourlyForcastArray = []
                let hours = min(24, hourlyDataArray.count-1)
                for hour in 1...hours{
                    let hourlyTime = json["hourly"]["data"][hour]["time"].doubleValue
                    let hourlyTemperature = json["hourly"]["data"][hour]["temperature"].doubleValue
                    let hourlyPrecipProb = json["hourly"]["data"][hour]["precipProbability"].doubleValue
                    let hourlyIcon = json["hourly"]["data"][hour]["icon"].stringValue
                    let newHourlyForcast = HourlyForcast(hourlyTime: hourlyTime, hourlyTemperature: hourlyTemperature, hourlyPrecipProb: hourlyPrecipProb, hourlyIcon: hourlyIcon)
                    self.hourlyForcastArray.append(newHourlyForcast)
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}


