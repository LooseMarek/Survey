//
//  TestDidEnoughTimePassedFromLastDisplay.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Helper_Survey_Test {
    
    func testDidEnoughTimePassFromLastDisplay_WhenFrequencyIsSetToZero_ShouldReturnTrue() {
        // Given
        let calendar = Calendar.current
        
        let pastDate = calendar.date(byAdding: .day, value: -1, to: mockDateNow)!
        let frequencyInDays: Int = 0

        // When
        let result = surveyHelper.didEnoughTimePassFromLastDisplay(from: pastDate, to: mockDateNow, frequencyInDays: frequencyInDays)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testDidEnoughTimePassFromLastDisplay_WhenFrequencyIsSetButPastDateIsToday_ShouldReturnFalse() {
        // Given
        let pastDate = mockDateNow
        let frequencyInDays = 10

        // When
        let result = surveyHelper.didEnoughTimePassFromLastDisplay(from: pastDate, to: mockDateNow, frequencyInDays: frequencyInDays)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testDidEnoughTimePassFromLastDisplay_WhenFrequencyIsSetButEnoughTimeDidntPass_ShouldReturnFalse() {
        // Given
        let calendar = Calendar.current
        
        let pastDate = calendar.date(byAdding: .day, value: -9, to: mockDateNow)!
        let frequencyInDays = 10

        // When
        let result = surveyHelper.didEnoughTimePassFromLastDisplay(from: pastDate, to: mockDateNow, frequencyInDays: frequencyInDays)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testDidEnoughTimePassFromLastDisplay_WhenFrequencyIsSetAndEnoughTimePassedToday_ShouldReturnTrue() {
        // Given
        let calendar = Calendar.current
        
        let pastDate = calendar.date(byAdding: .day, value: -10, to: mockDateNow)!
        let frequencyInDays = 10

        // When
        let result = surveyHelper.didEnoughTimePassFromLastDisplay(from: pastDate, to: mockDateNow, frequencyInDays: frequencyInDays)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testDidEnoughTimePassFromLastDisplay_WhenFrequencyIsSetAndEnoughTimeDidPass_ShouldReturnTrue() {
        // Given
        let calendar = Calendar.current
        
        let pastDate = calendar.date(byAdding: .day, value: -15, to: mockDateNow)!
        let frequencyInDays = 10

        // When
        let result = surveyHelper.didEnoughTimePassFromLastDisplay(from: pastDate, to: mockDateNow, frequencyInDays: frequencyInDays)
        
        // Then
        XCTAssertTrue(result)
    }
}
