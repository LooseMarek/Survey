//
//  TestPositiveButtonCallback.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest
import SafariServices

@testable import Survey

extension Survey_Test {
    
    func testPositiveButtonCallback_WhenCalled_ShouldUpdateUserDefaults() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        
        survey.setPresenter(presenter)

        // When
        survey.positiveButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(fakeUserDefaults.object(forKey: LogKey.buttonPressedTimestamp.rawValue) as? Date, mockDateNow)
        XCTAssertEqual(LogButtonType(rawValue: fakeUserDefaults.string(forKey: LogKey.buttonType.rawValue)!), LogButtonType.positive)
    }
    
    func testPositiveButtonCallback_WhenDeletageIsSet_ShouldCallDelegate() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        let delegate = MockSurveyDelegate()
        
        survey.setPresenter(presenter)
        survey.delegate = delegate

        // When
        survey.positiveButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(delegate.positiveButtonPressedCallsCount, 1)
    }
    
    func testPositiveButtonCallback_WhenCalled_ShouldPresentSafariViewController() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        
        survey.setPresenter(presenter)

        // When
        survey.positiveButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(presenter.presentCallCount, 1)
        XCTAssertTrue(presenter.mockViewControllerToPresent is SFSafariViewController)
    }
    
    func testPositiveButtonCallback_WhenCalled_ShouldDismissAlert() {
        // Given
        let presenter = MockViewController()
        let alert = MockAlertController()
        
        survey.setPresenter(presenter)

        // When
        survey.positiveButtonCallback(alert: alert, dateNow: mockDateNow)
        
        // Then
        XCTAssertEqual(alert.dismissCallCount, 1)
        XCTAssertTrue(alert.mockAnimated)
        XCTAssertNil(alert.mockCompletion)
    }
}
