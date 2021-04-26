//
//  MockAlertController.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import UIKit

class MockAlertController: UIAlertController {
    var dismissCallCount: Int = 0
    
    var mockAnimated: Bool = false
    var mockCompletion: (() -> Void)? = nil
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
        
        mockAnimated = flag
        mockCompletion = completion
    }
}
