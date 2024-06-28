//
//  MockSurveyDelegate.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

public class MockSurveyDelegate: SurveyDelegate {
    
    public var positiveButtonPressedCallsCount = 0
    public var neutralButtonPressedCallsCount = 0
    public var negativeButtonPressedCallsCount = 0
    
    public func positiveButtonPressed() {
        positiveButtonPressedCallsCount += 1
    }
    
    public func neutralButtonPressed() {
        neutralButtonPressedCallsCount += 1
    }
    
    public func negativeButtonPressed() {
        negativeButtonPressedCallsCount += 1
    }
}
