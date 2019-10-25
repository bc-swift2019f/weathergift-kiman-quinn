//
//  HourlyWeatherCell.swift
//  WeatherGift
//
//  Created by Kim-An Quinn on 10/25/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "ha"
    return dateFormatter
}()

class HourlyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var hourlyTime: UILabel!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    @IBOutlet weak var hourlyIcon: UIImageView!
    @IBOutlet weak var rainDropImage: UIImageView!
    
    func update(with hourlyForcast: WeatherLocation.HourlyForcast, timeZone: String){
        hourlyTemp.text = String(format: "%2.f", hourlyForcast.hourlyTemperature) + "°"
        hourlyIcon.image = UIImage(named: "small-" + hourlyForcast.hourlyIcon)
        let precipProb = hourlyForcast.hourlyPrecipProb * 100
        let isHidden = precipProb < 30
        hourlyPrecipProb.isHidden = isHidden
        rainDropImage.isHidden = isHidden
        hourlyPrecipProb.text = String(format: "%2.f", precipProb) + "%"
        let dateString = hourlyForcast.hourlyTime.format(timeZone: timeZone, dateFormatter: dateFormatter)
        hourlyTime.text = dateString
    }
    
}
