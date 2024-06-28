//
//  SurveyHelper.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import UIKit

protocol SurveyHelperProtocol {
    func canDisplayAlert(userDefaults: UserDefaults, displayFrequencyInDays: DisplayFrequencyInDays, dateNow: Date) -> Bool
    func didEnoughTimePassFromLastDisplay(from pastDate: Date, to now: Date, frequencyInDays: Int) -> Bool
}

extension SurveyHelperProtocol {
    func canDisplayAlert(userDefaults: UserDefaults, displayFrequencyInDays: DisplayFrequencyInDays, dateNow: Date = Date()) -> Bool {
        return canDisplayAlert(userDefaults: userDefaults, displayFrequencyInDays: displayFrequencyInDays, dateNow: dateNow)
    }
}

class SurveyHelper: SurveyHelperProtocol {
    
    func canDisplayAlert(userDefaults: UserDefaults, displayFrequencyInDays: DisplayFrequencyInDays, dateNow: Date = Date()) -> Bool {
        guard let buttonPressedTimestamp = userDefaults.object(forKey: LogKey.buttonPressedTimestamp.rawValue) as? Date,
            let buttonTypeRawValue = userDefaults.string(forKey: LogKey.buttonType.rawValue),
            let buttonType = LogButtonType(rawValue: buttonTypeRawValue) else {
            // No buttons had been pressed yet
            return true
        }
        
        let userDontWantToSeeAlertAgain = buttonType == LogButtonType.negative

        if userDontWantToSeeAlertAgain { return false }
        
        let frequencyInDays: Int = buttonType == LogButtonType.neutral ? displayFrequencyInDays.fromAskLater : displayFrequencyInDays.fromFilled
        
        return didEnoughTimePassFromLastDisplay(from: buttonPressedTimestamp, to: dateNow, frequencyInDays: frequencyInDays)
    }
    
    func didEnoughTimePassFromLastDisplay(from pastDate: Date, to now: Date, frequencyInDays: Int) -> Bool {
        let calendar = Calendar.current

        let dateFrom = calendar.startOfDay(for: pastDate)
        let dateTo = calendar.startOfDay(for: now)
        
        let components = calendar.dateComponents([.day], from: dateFrom, to: dateTo)

        return components.day! >= frequencyInDays
    }
}
