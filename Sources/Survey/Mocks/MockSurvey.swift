//
//  MockSurvey.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import UIKit

public class MockSurvey: SurveyProtocol {
    
    public var setUserDefaultsCallsCount: Int = 0
    public var setPresenterCallsCount: Int = 0
    public var setLinkCallsCount: Int = 0
    public var setAlertLabelsCallsCount: Int = 0
    public var setDisplayFrequencyCallsCount: Int = 0
    public var showAlertCallsCount: Int = 0
    public var forceShowAlertCallsCount: Int = 0
    public var resetButtonPressLogsCallsCount: Int = 0
    
    public var mockUserDefaults: UserDefaults?
    public var mockPresenter: UIViewController?
    public var mockLink: String?
    public var mockAlertLabels: AlertLabels?
    public var mockDisplayFrequency: DisplayFrequencyInDays?

    public weak var delegate: SurveyDelegate?
    
    public init() { }
    
    public func setUserDefaults(_ userDefaults: UserDefaults) -> Self {
        setUserDefaultsCallsCount += 1
        
        mockUserDefaults = userDefaults

        return self
    }
    
    public func setPresenter(_ presenter: UIViewController) -> Self {
        setPresenterCallsCount += 1
        
        mockPresenter = presenter

        return self
    }
    
    public func setLink(_ link: String) -> Self {
        setLinkCallsCount += 1
        
        mockLink = link

        return self
    }
    
    public func setAlertLabels(_ alertLabels: AlertLabels) -> Self {
        setAlertLabelsCallsCount += 1
        
        mockAlertLabels = alertLabels

        return self
    }
    
    public func setDisplayFrequency(_ displayFrequencyInDays: DisplayFrequencyInDays) -> Self {
        setDisplayFrequencyCallsCount += 1
        
        mockDisplayFrequency = displayFrequencyInDays

        return self
    }
    
    public func showAlert() throws {
        showAlertCallsCount += 1
    }
    
    public func forceShowAlert() throws {
        forceShowAlertCallsCount += 1
    }
    
    public func resetButtonPressLogs() {
        resetButtonPressLogsCallsCount += 1
    }
}
