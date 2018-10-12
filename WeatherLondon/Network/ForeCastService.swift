//
//  ForeCastService.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

public protocol ForeCastService {

    func getForeCast(completion: @escaping (Bool, PR2HTTPCode, [String: Any]) -> Void)

}
