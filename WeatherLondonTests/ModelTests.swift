//
//  ModelTests.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 12/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import XCTest
import PR2StudioSwift

class ModelTests: XCTestCase {
    
    func testForeCastInitJSON() {
        let jsonData = PR2Common().readJSONFileAsDict(file: "5dayforecast")
        
        let foreCast = ForeCast(json: jsonData)
        XCTAssertNotNil(foreCast)
        XCTAssertEqual(foreCast.list.first?.temp, 17.24)
        XCTAssertEqual(foreCast.list.first?.tempMax, 17.24)
        XCTAssertEqual(foreCast.list.first?.tempMin, 16.9)
        XCTAssertEqual(foreCast.list.first?.wmain, "Clouds")
        XCTAssertEqual(foreCast.list.first?.icon, "04d")
        XCTAssertEqual(foreCast.list.first?.suggestion, .other)

        XCTAssertEqual(foreCast.list[1].suggestion, .umbrella)
        XCTAssertEqual(foreCast.list[2].suggestion, .sunglasses)
    }
    
}
