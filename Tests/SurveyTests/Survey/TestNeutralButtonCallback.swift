//
//  TestNeutralButtonCallback.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Survey_Test {
    
    func testNeutralButtonCallback_WhenCalled_ShouldUpdateUserDefaults() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        
        survey.setPresenter(presenter)

        // When
        survey.neutralButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(fakeUserDefaults.object(forKey: LogKey.buttonPressedTimestamp.rawValue) as? Date, mockDateNow)
        XCTAssertEqual(LogButtonType(rawValue: fakeUserDefaults.string(forKey: LogKey.buttonType.rawValue)!), LogButtonType.neutral)
    }
    
    func testNeutralButtonCallback_WhenDeletageIsSet_ShouldCallDelegate() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        let delegate = MockSurveyDelegate()
        
        survey.setPresenter(presenter)
        survey.delegate = delegate

        // When
        survey.neutralButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(delegate.neutralButtonPressedCallsCount, 1)
    }
    
    func testNeutralButtonCallback_WhenCalled_ShouldDismissAlert() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        
        survey.setPresenter(presenter)

        // When
        survey.neutralButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(alert.dismissCallCount, 1)
        XCTAssertTrue(alert.mockAnimated)
        XCTAssertNil(alert.mockCompletion)
    }
}

