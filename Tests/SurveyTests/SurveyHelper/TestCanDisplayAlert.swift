//
//  TestCanDisplayAlert.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Helper_Survey_Test {
    
    func testCanDisplayAlert_WhenNoButtonPressHaventBeenLogged_ShouldReturnTrue() {
        // Given
        let displayFrequency = DisplayFrequencyInDays(fromFilled: 30, fromAskLater: 10)

        // When
        let result = surveyHelper.canDisplayAlert(userDefaults: fakeUserDefaults, displayFrequencyInDays: displayFrequency, dateNow: mockDateNow)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testCanDisplayAlert_WhenNegativeButtonPressHaveBeenLogged_ShouldReturnFalse() {
        // Given
        fakeUserDefaults.set(mockDateNow, forKey: LogKey.buttonPressedTimestamp.rawValue)
        fakeUserDefaults.set(LogButtonType.negative.rawValue, forKey: LogKey.buttonType.rawValue)
        
        let displayFrequency = DisplayFrequencyInDays(fromFilled: 30, fromAskLater: 10)

        // When
        let result = surveyHelper.canDisplayAlert(userDefaults: fakeUserDefaults, displayFrequencyInDays: displayFrequency, dateNow: mockDateNow)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testCanDisplayAlert_WhenNeutralButtonPressHaveBeenLoggedButNotEnoughTimePassedFromLastLog_ShouldReturnFalse() {
        // Given
        let calendar = Calendar.current
        let logTimestamp = calendar.date(byAdding: .day, value: -1, to: mockDateNow)!
        
        let displayFrequency = DisplayFrequencyInDays(fromFilled: 30, fromAskLater: 10)

        fakeUserDefaults.set(logTimestamp, forKey: LogKey.buttonPressedTimestamp.rawValue)
        fakeUserDefaults.set(LogButtonType.neutral.rawValue, forKey: LogKey.buttonType.rawValue)

        // When
        let result = surveyHelper.canDisplayAlert(userDefaults: fakeUserDefaults, displayFrequencyInDays: displayFrequency, dateNow: mockDateNow)

        // Then
        XCTAssertFalse(result)
    }
    
    func testCanDisplayAlert_WhenNeutralButtonPressHaveBeenLoggedAndEnoughTimePassedFromLastLog_ShouldReturnTrue() {
        // Given
        let calendar = Calendar.current
        let logTimestamp = calendar.date(byAdding: .day, value: -15, to: mockDateNow)!
        
        let displayFrequency = DisplayFrequencyInDays(fromFilled: 30, fromAskLater: 10)

        fakeUserDefaults.set(logTimestamp, forKey: LogKey.buttonPressedTimestamp.rawValue)
        fakeUserDefaults.set(LogButtonType.neutral.rawValue, forKey: LogKey.buttonType.rawValue)

        // When
        let result = surveyHelper.canDisplayAlert(userDefaults: fakeUserDefaults, displayFrequencyInDays: displayFrequency, dateNow: mockDateNow)

        // Then
        XCTAssertTrue(result)
    }
    
    func testCanDisplayAlert_WhenPositiveButtonPressHaveBeenLoggedButNotEnoughTimePassedFromLastLog_ShouldReturnFalse() {
        // Given
        let calendar = Calendar.current
        let logTimestamp = calendar.date(byAdding: .day, value: -15, to: mockDateNow)!
        
        let displayFrequency = DisplayFrequencyInDays(fromFilled: 30, fromAskLater: 10)

        fakeUserDefaults.set(logTimestamp, forKey: LogKey.buttonPressedTimestamp.rawValue)
        fakeUserDefaults.set(LogButtonType.positive.rawValue, forKey: LogKey.buttonType.rawValue)

        // When
        let result = surveyHelper.canDisplayAlert(userDefaults: fakeUserDefaults, displayFrequencyInDays: displayFrequency, dateNow: mockDateNow)

        // Then
        XCTAssertFalse(result)
    }
    
    func testCanDisplayAlert_WhenPositiveButtonPressHaveBeenLoggedAndEnoughTimePassedFromLastLog_ShouldReturnTrue() {
        // Given
        let calendar = Calendar.current
        let logTimestamp = calendar.date(byAdding: .day, value: -45, to: mockDateNow)!
        
        let displayFrequency = DisplayFrequencyInDays(fromFilled: 30, fromAskLater: 10)

        fakeUserDefaults.set(logTimestamp, forKey: LogKey.buttonPressedTimestamp.rawValue)
        fakeUserDefaults.set(LogButtonType.positive.rawValue, forKey: LogKey.buttonType.rawValue)

        // When
        let result = surveyHelper.canDisplayAlert(userDefaults: fakeUserDefaults, displayFrequencyInDays: displayFrequency, dateNow: mockDateNow)

        // Then
        XCTAssertTrue(result)
    }
}
