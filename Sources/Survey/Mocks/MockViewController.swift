//
//  MockViewController.swift
//  Survey
//
//  Created by Marek Loose on 08/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import UIKit

class MockViewController: UIViewController {
    
    var presentCallCount = 0
    
    var mockViewControllerToPresent: UIViewController?
    var mockAnimated = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
        
        mockAnimated = flag
        mockViewControllerToPresent = viewControllerToPresent
    }
}
