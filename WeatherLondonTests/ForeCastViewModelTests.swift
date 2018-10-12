//
//  ForeCastViewModelTests.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 26/9/17.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import XCTest

class ForeCastViewModelTests: XCTestCase {
    
    var viewModel: ForeCastViewModel?
    
    override func setUp() {
        super.setUp()
        self.viewModel = ForeCastViewModel()
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testReadData() {
        viewModel?.readData { (success) in
            XCTAssertEqual(self.viewModel?.numberOfSections(), 6)
            XCTAssertEqual(self.viewModel?.numberOfRowsInSection(section: 0), 4)
        }
    }
    
    func testRow() {
        viewModel?.readData {[unowned self] (success) in
            if let row = self.viewModel?.row(at: IndexPath(row: 0, section: 0)) {
                XCTAssertEqual(row.lblHour, "14:00")
                XCTAssertEqual(row.icon, "04d")
                XCTAssertEqual(row.lblWeatherType, "Clouds")
                XCTAssertEqual(row.lblTemp, "17.2°")
            }
        }
    }
    
}
