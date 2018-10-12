//
//  ForeCastServiceRemote.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

struct ForeCastServiceRemote: ForeCastService {

    func getForeCast(completion: @escaping (Bool, PR2HTTPCode, [String: Any]) -> Void) {

        let url = String(format: APIConstants.forecast5, DefaultData.City.id)

        let pollingResults = PR2NetworkTask(method: "GET", url: url, params: nil, headers: nil, priority: Operation.QueuePriority.normal, pollforUTC: 0, networkOperationCompletionHandler: { (success, response) in

            if let result = response.result.value {
                let json = result as! [String: Any]
                //debugPrint(json)
                completion(true, PR2HTTPCode(value: (response.response?.statusCode)!), json)
            }

        })
        PR2Networking.sharedInstance.addTask(pollingResults)

    }

}
