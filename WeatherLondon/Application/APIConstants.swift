//
//  APIConstants.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

/// End Points
struct APIConstants {
    
    /// http protocol
    static let httpprotocol = "http"

    /// https protocol
    static let httpsprotocol = "https"

    /// base url
    static let mainurl = "\(httpsprotocol)://api.openweathermap.org/data/2.5/"

    /// API Key
    static let apiKey = "9ab980154b2797d68656609717cbb4e6"

    /// EP for forecast5 (by cityid)
    static let forecast5 = "\(mainurl)forecast?id=%@&units=metric&mode=json&appid=\(apiKey)"
    
    /// EP for images
    static let image = "http://openweathermap.org/img/w/"
    
}
