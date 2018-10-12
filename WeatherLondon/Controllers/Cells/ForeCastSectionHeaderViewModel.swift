//
//  ForeCastSectionHeaderViewModel.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

struct ForeCastSectionHeaderViewModel {
    let title: String
    let tempMin: Double
    let tempMax: Double
    var suggestion: String

    init(title: String, tempMin: Double, tempMax: Double, suggestion: String) {
        self.title = title
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.suggestion = suggestion
    }
}
