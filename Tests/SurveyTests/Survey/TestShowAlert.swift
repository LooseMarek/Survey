//
//  TestShowAlert.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Survey_Test {
    
    func testShowAlert_WhenPresenterIsNotSet_ShouldThrowError() {
        // Given
        // N/A

        // When / Then
        XCTAssertThrowsError(try survey.showAlert()) { error in
            XCTAssertEqual(error as! OpenLinkError, .presenterNotSet)
        }
    }
    
    func testShowAlert_WhenPresenterIsSetButCantDisplayAlert_ShouldNotPresentAlert() {
        // Given
        let presenter = MockViewController()
        survey.setPresenter(presenter)
        let surveyHelper = MockSurveyHelper()
        surveyHelper.mockCanDisplayAlert = false
        survey.surveyHelper = surveyHelper

        // When
        try! survey.showAlert()
        
        // Then
        XCTAssertEqual(surveyHelper.canDisplayAlertCallsCount, 1)
        XCTAssertEqual(presenter.presentCallCount, 0)
    }
    
    func testShowAlert_WhenPresenterIsSetAndCanDisplayAlert_ShouldPresentAlert() {
        // Given
        let presenter = MockViewController()
        survey.setPresenter(presenter)
        let surveyHelper = MockSurveyHelper()
        surveyHelper.mockCanDisplayAlert = true
        survey.surveyHelper = surveyHelper

        // When
        try! survey.showAlert()
        
        // Then
        XCTAssertEqual(surveyHelper.canDisplayAlertCallsCount, 1)
        XCTAssertEqual(presenter.presentCallCount, 1)
        XCTAssertTrue(presenter.mockViewControllerToPresent is UIAlertController)
        XCTAssertTrue(presenter.mockAnimated)
    }
}
