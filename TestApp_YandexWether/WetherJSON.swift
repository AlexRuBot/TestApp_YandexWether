//
//  WetherJSON.swift
//  TestApp_YandexWether
//
//  Created by Саша Гужавин on 24.01.2021.
//


import Foundation

// MARK: - Wether
struct WetherJSON: Codable {
    let fact: Fact
    let geoObject: GeoObject
    
    enum CodingKeys: String, CodingKey {
        case fact
        case geoObject = "geo_object"
    }
}

struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let condition: String
    let windSpeed: Double
    let windDir: String
    let pressure: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
    }

}

struct GeoObject: Codable {
    let locality: Locality
    }

struct Locality: Codable {
    let name: String
}
