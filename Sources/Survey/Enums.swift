//
//  LogEnums.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

enum LogKey: String {
    case buttonType = "surveyButtonTypeKey"
    case buttonPressedTimestamp = "surveyButtonPressedTimestampKey"
}

enum LogButtonType: String {
    case positive = "surveyPositiveButton"
    case neutral = "surveyNeutralButton"
    case negative = "surveyNegativeButton"
}

enum OpenLinkError: Error {
    case cantConvertLinkToUrl
    case presenterNotSet
}
