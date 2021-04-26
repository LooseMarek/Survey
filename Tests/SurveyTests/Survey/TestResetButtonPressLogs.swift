//
//  TestResetButtonPressLogs.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Survey_Test {
    
    func testResetButtonPressLogs_WhenCalled_ShouldResetUserDefaultsLogs() {
        // Given
        fakeUserDefaults.set(mockDateNow, forKey: LogKey.buttonPressedTimestamp.rawValue)
        fakeUserDefaults.set(LogButtonType.positive.rawValue, forKey: LogKey.buttonType.rawValue)
        
        XCTAssertEqual(fakeUserDefaults.object(forKey: LogKey.buttonPressedTimestamp.rawValue) as? Date, mockDateNow)
        XCTAssertEqual(LogButtonType(rawValue: fakeUserDefaults.string(forKey: LogKey.buttonType.rawValue)!), LogButtonType.positive)

        // When
        survey.resetButtonPressLogs()
        
        // Then
        XCTAssertNil(fakeUserDefaults.object(forKey: LogKey.buttonPressedTimestamp.rawValue) as? Date)
        XCTAssertNil(fakeUserDefaults.string(forKey: LogKey.buttonType.rawValue))
    }
}
