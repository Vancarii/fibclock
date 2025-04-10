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
    
    
    
