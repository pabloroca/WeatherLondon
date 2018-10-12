//
//  ForeCast.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

struct ForeCast: Loopable {
    var code: Int
    var list: [ForeCastItem]

    init(code: Int, list: [ForeCastItem]) {
        self.code = code
        self.list = list
    }

    init(json: [String: Any]) {
        let code = json["code"] as? Int ?? 0

        let listJSON = json["list"] as? [[String: Any]] ?? []
        let listArray = listJSON.map { ForeCastItem(json: $0) }

        self.init(code: code, list: listArray)
    }

}
