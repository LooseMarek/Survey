//
//  TestInit.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest

@testable import Survey

extension Survey_Test {
    
    func testInit_WhenCalled_ShouldReturnSurvey() {
        // Given
        // N/A

        // When
        // N/A - Done on setUp()
        
        // Then
        XCTAssertNotNil(survey)
    }
}
