//
//  ServiceFactory.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

struct ServiceFactory {

    //HERE: Select Mocks or not Mocks
    
    static func ForeCastService() -> ForeCastService {
        return ForeCastServiceRemote()
    }

}
