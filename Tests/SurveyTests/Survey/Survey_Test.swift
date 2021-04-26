//
//  Survey_Test.swift
//  Survey
//
//  Created by Marek Loose on 07/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

class Survey_Test: XCTestCase {
    
    let mockDateNow: Date = Date(timeIntervalSinceReferenceDate: 628869000) // 5 December 2020, 13:50GMT
    let userDefaultSuiteName = "testSurveyUserDefaults"
    
    var fakeUserDefaults: UserDefaults!
    var survey: Survey!

    override func setUp() {
        super.setUp()
        fakeUserDefaults = UserDefaults(suiteName: userDefaultSuiteName)
        survey = Survey()
        survey.setUserDefaults(fakeUserDefaults)
    }

    override func tearDown() {
        fakeUserDefaults.removePersistentDomain(forName: userDefaultSuiteName)
        fakeUserDefaults = nil
        survey = nil
        super.tearDown()
    }
}
