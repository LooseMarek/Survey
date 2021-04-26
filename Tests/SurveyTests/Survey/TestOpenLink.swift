//
//  TestOpenLink.swift
//  SurveyTests
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import XCTest
import SafariServices

@testable import Survey

extension Survey_Test {
    
    func testOpenLink_WhenLinkCantBeConvertedToUrl_ShouldThrowError() {
        // Given
        let invalidLink = ""
        
        survey.setLink(invalidLink)

        // When / Then
        XCTAssertThrowsError(try survey.openLink()) { error in
            XCTAssertEqual(error as! OpenLinkError, .cantConvertLinkToUrl)
        }
    }
    
    func testOpenLink_WhenPresenterIsNotSet_ShouldThrowError() {
        // Given
        // N/A

        // When / Then
        XCTAssertThrowsError(try survey.openLink()) { error in
            XCTAssertEqual(error as! OpenLinkError, .presenterNotSet)
        }
    }
    
    func testOpenLink_WhenLinkIsValidAndPresenterIsSet_ShouldPresentSafariViewController() {
        // Given
        let presenter = MockViewController()

        survey.setPresenter(presenter)

        // When
        try! survey.openLink()
        
        // Then
        XCTAssertEqual(presenter.presentCallCount, 1)
        XCTAssertTrue(presenter.mockViewControllerToPresent is SFSafariViewController)
    }
}
