//
//  DisplayFrequencyInDays.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

public struct DisplayFrequencyInDays {
    
    /**
     Number of day from last time User filled the survey.
     Default to 90 days (3 months) set on init.
    */
    private(set) var fromFilled: Int
    /**
     Number of day from last time User press neutral button (Ask later),
     Default to 14 days (2 weeks) set on init.
    */
    private(set) var fromAskLater: Int
    
    public init(fromFilled: Int = 90, fromAskLater: Int = 14) {
        self.fromFilled = fromFilled
        self.fromAskLater = fromAskLater
    }
}
