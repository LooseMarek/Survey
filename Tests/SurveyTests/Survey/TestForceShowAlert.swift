//
//  TestForceShowAlert.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Survey_Test {
    
    func testForceShowAlert_WhenPresenterIsNotSet_ShouldThrowError() {
        // Given
        // N/A

        // When / Then
        XCTAssertThrowsError(try survey.forceShowAlert()) { error in
            XCTAssertEqual(error as! OpenLinkError, .presenterNotSet)
        }
    }
    
    func testForceShowAlert_WhenPresenterIsSet_ShouldPresentAlertWithoutCheckingLogs() {
        // Given
        let presenter = MockViewController()
        survey.setPresenter(presenter)
        let surveyHelper = MockSurveyHelper()
        survey.surveyHelper = surveyHelper

        // When
        try! survey.forceShowAlert()
        
        // Then
        XCTAssertEqual(surveyHelper.canDisplayAlertCallsCount, 0)
        XCTAssertEqual(presenter.presentCallCount, 1)
        XCTAssertTrue(presenter.mockViewControllerToPresent is UIAlertController)
        XCTAssertTrue(presenter.mockAnimated)
    }
}
