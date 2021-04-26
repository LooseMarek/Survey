//
//  MockSurveyHelper.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import UIKit

class MockSurveyHelper: SurveyHelperProtocol {
    
    var canDisplayAlertCallsCount: Int = 0
    var didEnoughTimePassFromLastDisplayCallsCount: Int = 0
    
    var mockCanDisplayAlert: Bool = false
    var mockDidEnoughTimePassFromLastDisplay: Bool = false
    
    func canDisplayAlert(userDefaults: UserDefaults, displayFrequencyInDays: DisplayFrequencyInDays, dateNow: Date = Date()) -> Bool {
        canDisplayAlertCallsCount += 1

        return mockCanDisplayAlert
    }
    
    func didEnoughTimePassFromLastDisplay(from pastDate: Date, to now: Date, frequencyInDays: Int) -> Bool {
        didEnoughTimePassFromLastDisplayCallsCount += 1

        return mockDidEnoughTimePassFromLastDisplay
    }
}
