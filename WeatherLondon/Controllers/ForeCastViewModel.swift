//
//  ForeCastViewModel.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

final class ForeCastViewModel {
    var title = DefaultData.defaultTitle

    struct ForeCastSection {
        let viewModel: ForeCastSectionHeaderViewModel
        let cells: [ForeCastItem]
    }

    var sections: [ForeCastSection] = []

    func readData(completion: @escaping (Bool) -> Void) {
        ServiceFactory.ForeCastService().getForeCast { [weak self] (success, httpcode, resultsJSON) in
            guard let self = self else { return }
            if success {
                let foreCast = ForeCast(json: resultsJSON)
                self.processDataToSections(list: foreCast.list)
                completion(true)
            } else {
                // fail gracefully - no UI
                completion(false)
            }
        }
    }

    private func processDataToSections(list: [ForeCastItem]) {
        var mySections: [String: ForeCastSectionHeaderViewModel] = [:]
        var myCells: [String: [ForeCastItem]] = [:]

        for element in list {
            let dateString = Date(timeIntervalSince1970: element.dt).PR2DateFormatterDayWeek()
            let datedayString = Date(timeIntervalSince1970: element.dt).PR2DateFormatterYYYYMMDD()

            if let section = mySections[datedayString] {
                let newTempMin = section.tempMin > element.tempMin ? element.tempMin : section.tempMin
                let newTempMax = section.tempMax < element.tempMax ? element.tempMax : section.tempMax

                mySections[datedayString] = ForeCastSectionHeaderViewModel(title: dateString, tempMin: newTempMin, tempMax: newTempMax, suggestion: "")
            } else {
                mySections[datedayString] = ForeCastSectionHeaderViewModel(title: dateString, tempMin: element.tempMin, tempMax: element.tempMax, suggestion: "")
            }

            // process weather cells by time
            if let existingCells = myCells[datedayString] {
                var cells = existingCells
                cells.append(element)
                myCells[datedayString] = cells
            } else {
                myCells[datedayString] = [element]
            }
        }

        let sortedKeys = Array(mySections.keys).sorted(by: <)

        for key in sortedKeys {
            if var section = mySections[key], let cells = myCells[key] {
                var countSunGlasses = 0
                var countUmbrella = 0
                var countOther = 0

                for cell in cells {
                    countSunGlasses += cell.suggestion == .sunglasses ? 1 : 0
                    countUmbrella += cell.suggestion == .umbrella ? 1 : 0
                    countOther += cell.suggestion == .other ? 1 : 0
                }

                if countUmbrella > 0 {
                    section.suggestion = NSLocalizedString("Umbrella", comment: "")
                } else if countOther > 0 {
                    section.suggestion = NSLocalizedString("Fair", comment: "")
                } else {
                    section.suggestion = NSLocalizedString("Sunglasses", comment: "")
                }

                sections.append(ForeCastSection(viewModel: section, cells: cells))
            }
        }
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return sections[section].cells.count
    }

    func headerViewModel(section: Int) -> ForeCastSectionHeaderViewModel {
        return sections[section].viewModel
    }

    func row(at indexpath: IndexPath) -> ForeCastCellViewModel {
        let row = sections[indexpath.section].cells[indexpath.row]

        var rowViewModel = ForeCastCellViewModel(lblHour: "", icon: row.icon, lblWeatherType: row.wmain, lblTemp: "\(row.temp.toPriceString(decimalDigits: 1, currencySymbol: "", thousandsSeparator: ",", decimalSeparator: "."))°")

        let date = Date(timeIntervalSince1970: row.dt)
        rowViewModel.lblHour = date.PR2DateFormatterHHMM()

        return rowViewModel
    }

}
