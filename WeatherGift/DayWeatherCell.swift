//
//  DayWeatherCell.swift
//  WeatherGift
//
//  Created by Kim-An Quinn on 10/24/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {

    @IBOutlet weak var dayCellIcon: UIImageView!
    @IBOutlet weak var dayCellWeekday: UILabel!
    @IBOutlet weak var dayCellMaxTemp: UILabel!
    @IBOutlet weak var dayCellMinTemp: UILabel!
    @IBOutlet weak var dayCellSummary: UITextView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with dailyForcast: WeatherLocation.DailyForcast, timeZone: String){
        dayCellIcon.image = UIImage.init(named: dailyForcast.dailyIcon)
        dayCellSummary.text = dailyForcast.dailySummary
        dayCellMaxTemp.text = String(format: "%2.f", dailyForcast.dailyMaxTemp) + "°"
        dayCellMinTemp.text = String(format: "%2.f", dailyForcast.dailyMinTemp) + "°"
        
        let usableDate = Date(timeIntervalSince1970: dailyForcast.dailyDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        dayCellWeekday.text = dateString
        
    }

}
