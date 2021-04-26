//
//  TestCreateAlert.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Survey_Test {
    
    func testCreateAlert_WhenCalled_ShouldReturnAlertWithThreeActions() {
        // Given
        var alertLabels = AlertLabels()
        alertLabels.title = "test title"
        alertLabels.message = "test message"
        alertLabels.positiveButton = "test positiveButton"
        alertLabels.neutralButton = "test neutralButton"
        alertLabels.negativeButton = "test negativeButton"
        
        survey.setAlertLabels(alertLabels)

        // When
        let result: UIAlertController = survey.createAlert()
        
        // Then
        XCTAssertEqual(result.title, alertLabels.title)
        XCTAssertEqual(result.message, alertLabels.message)
        XCTAssertEqual(result.actions[0].style, .default)
        XCTAssertEqual(result.actions[1].style, .default)
        XCTAssertEqual(result.actions[2].style, .cancel)
        XCTAssertEqual(result.actions[0].title, alertLabels.positiveButton)
        XCTAssertEqual(result.actions[1].title, alertLabels.neutralButton)
        XCTAssertEqual(result.actions[2].title, alertLabels.negativeButton)
    }
}
