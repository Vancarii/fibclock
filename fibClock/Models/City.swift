//
//  City.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import Foundation

// This model contains the information of a city, using Equatable to compare and select the city
struct City: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let timeZoneIdentifier: String
}
    
// List of available cities
struct CityManager {
    static let cities: [City] = [
        City(name: "Vancouver", timeZoneIdentifier: "America/Vancouver"),
        City(name: "Singapore", timeZoneIdentifier: "Asia/Singapore"),
        City(name: "London", timeZoneIdentifier: "Europe/London"),
        City(name: "Seoul", timeZoneIdentifier: "Asia/Seoul"),
        City(name: "Christchurch", timeZoneIdentifier: "Pacific/Auckland"),
    ]
}
    
    
