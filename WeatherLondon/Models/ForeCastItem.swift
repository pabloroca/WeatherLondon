//
//  ForeCastItem.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

enum SuggestionType {
    case sunglasses
    case umbrella
    case other
}

public struct ForeCastItem: Loopable {
    var dt: Double
    var temp: Double
    var tempMax: Double
    var tempMin: Double
    var wmain: String
    var icon: String
    var suggestion: SuggestionType

    init(dt: Double, temp: Double, tempMax: Double, tempMin: Double, wmain: String, icon: String, suggestion: SuggestionType) {
        self.dt = dt
        self.temp = temp
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.wmain = wmain
        self.icon = icon
        self.suggestion = suggestion
    }

    init(json: [String: Any]) {
        let dt = json["dt"] as? Double ?? 0

        let main = json["main"] as? [String: Any] ?? [:]
        let temp = main["temp"] as? Double ?? 0
        let tempMax = main["temp_max"] as? Double ?? 0
        let tempMin = main["temp_min"] as? Double ?? 0

        var wmain: String = ""
        var icon: String = ""

        let weather = json["weather"] as? [[String: Any]] ?? [[:]]
        if let weatherFirst = weather.first {
            wmain = weatherFirst["main"] as? String ?? ""
            icon = weatherFirst["icon"] as? String ?? ""
        }

        let clouds = json["clouds"] as? [String: Any] ?? [:]
        let cloudsall = clouds["all"] as? Double ?? 0

        let rain = json["rain"] as? [String: Any] ?? [:]
        let rain3h = rain["3h"] as? Double ?? 0
        var suggestion: SuggestionType

        suggestion = rain3h > 0 ? .umbrella : (cloudsall == 0 ? .sunglasses : .other)

        self.init(dt: dt, temp: temp, tempMax: tempMax, tempMin: tempMin, wmain: wmain, icon: icon, suggestion: suggestion)
    }
}
