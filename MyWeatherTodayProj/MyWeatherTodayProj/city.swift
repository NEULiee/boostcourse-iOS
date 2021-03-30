//
//  City.swift
//  MyWeatherTodayProj
//
//  Created by Ha Neul Iee on 2021/03/19.
//

import Foundation

/*
 {
    "city_name":"파리",
    "state":10,
    "celsius":11.3,
    "rainfall_probability":90
 }
 
 10 : sunny
 11 : cloudy
 12 : rainy
 13 : snowy
 */

struct City: Codable {
    let cityName: String
    let state: Int
    let celsius: Float
    let rainfallProbability: Int
    
    var temperatures: String {
        return "섭씨 \(String(format: "%.2f", self.celsius))도 / 화씨 \(String(format: "%.2f", self.celsius * 9 / 5 + 32))도"
    }
    
    var showRainfallProbability: String {
        return "강수확률 " + "\(self.rainfallProbability)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case state, celsius
        case rainfallProbability = "rainfall_probability"
    }
}
