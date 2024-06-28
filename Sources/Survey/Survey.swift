//
//  Survey.swift
//  Survey
//
//  Created by Marek Loose on 07/02/2021.
//  Copyright © 2021 Marek Loose. All rights reserved.
//

import UIKit
import SafariServices

@objc public protocol SurveyDelegate: AnyObject {
    
    /**
     Tells the delegate that User pressed the positive button.
     It's called **before** opening the link.
    */
    @objc optional func positiveButtonPressed()
    /**
     Tells the delegate that User pressed the neutral button.
     It's called **before** dismissing the alert.
    */
    @objc optional func neutralButtonPressed()
    /**
     Tells the delegate that User pressed the negative button.
     It's called **before** dismissing the alert.
    */
    @objc optional func negativeButtonPressed()
}

public protocol SurveyProtocol {
    
    var delegate: SurveyDelegate? { get set }
    
    @discardableResult
    func setUserDefaults(_ userDefaults: UserDefaults) -> Self
    @discardableResult
    func setPresenter(_ presenter: UIViewController) -> Self
    @discardableResult
    func setLink(_ link: String) -> Self
    @discardableResult
    func setAlertLabels(_ alertLabels: AlertLabels) -> Self
    @discardableResult
    func setDisplayFrequency(_ displayFrequencyInDays: DisplayFrequencyInDays) -> Self
    
    func showAlert() throws
    func forceShowAlert() throws
    func resetButtonPressLogs()
}

public class Survey: SurveyProtocol {
    
    public weak var delegate: SurveyDelegate?
    
    private var userDefaults = UserDefaults.standard
    
    var surveyHelper: SurveyHelperProtocol = SurveyHelper()
    
    /**
     ViewController which will display alert.
     */
    private var presenter: UIViewController?
    /**
     Link to a survey which will be open in a default browser when User will press positive button.
     */
    private var link: String = "https://www.google.com/"
    
    private var alertLabels = AlertLabels()

    private var displayFrequencyInDays = DisplayFrequencyInDays()
        
    // MARK: - Init
    
    public init() { }
    
    // MARK: - Setters
    
    @discardableResult
    public func setUserDefaults(_ userDefaults: UserDefaults) -> Self {
        self.userDefaults = userDefaults
        return self
    }
    
    @discardableResult
    public func setPresenter(_ presenter: UIViewController) -> Self {
        self.presenter = presenter
        return self
    }
    
    @discardableResult
    public func setLink(_ link: String) -> Self {
        self.link = link
        return self
    }
    
    @discardableResult
    public func setAlertLabels(_ alertLabels: AlertLabels) -> Self {
        self.alertLabels = alertLabels
        return self
    }
    
    @discardableResult
    public func setDisplayFrequency(_ displayFrequencyInDays: DisplayFrequencyInDays) -> Self {
        self.displayFrequencyInDays = displayFrequencyInDays
        return self
    }
    
    // MARK: - Actions
    
    /**
     Shows alert **only** if frequency criteria had been met.
    */
    public func showAlert() throws {
        guard let presenter else { throw OpenLinkError.presenterNotSet }
        guard surveyHelper.canDisplayAlert(userDefaults: userDefaults, displayFrequencyInDays: displayFrequencyInDays) else { return }
        
        let alert: UIAlertController = createAlert()
        presenter.present(alert, animated: true, completion: nil)
    }
    
    /**
     Shows alert **by ignoring** frequency criteria.
    */
    public func forceShowAlert() throws {
        guard let presenter else { throw OpenLinkError.presenterNotSet }
        
        let alert: UIAlertController = createAlert()
        presenter.present(alert, animated: true, completion: nil)
    }
    
    /**
     Resets timestamp logs of button pressed by the User.
    */
    public func resetButtonPressLogs() {
        userDefaults.set(nil, forKey: LogKey.buttonType.rawValue)
        userDefaults.set(nil, forKey: LogKey.buttonPressedTimestamp.rawValue)
    }
    
    // MARK: - Helpers
    
    func createAlert() -> UIAlertController {
        let alert = UIAlertController(title: alertLabels.title, message: alertLabels.message, preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: alertLabels.positiveButton, style: .default, handler: { [weak self] (action: UIAlertAction!) in
            self?.positiveButtonCallback(alert: alert)
        }))

        alert.addAction(UIAlertAction(title: alertLabels.neutralButton, style: .default, handler: { [weak self] (action: UIAlertAction!) in
            self?.neutralButtonCallback(alert: alert)
        }))
        
        alert.addAction(UIAlertAction(title: alertLabels.negativeButton, style: .cancel, handler: { [weak self] (action: UIAlertAction!) in
            self?.negativeButtonCallback(alert: alert)
        }))
        
        return alert
    }
    
    func positiveButtonCallback(alert: UIAlertController, dateNow: Date = Date()) {
        userDefaults.set(dateNow, forKey: LogKey.buttonPressedTimestamp.rawValue)
        userDefaults.set(LogButtonType.positive.rawValue, forKey: LogKey.buttonType.rawValue)
                    
        if let delegate, let positiveButtonPressed = delegate.positiveButtonPressed {
            positiveButtonPressed()
        }
        
        try! openLink()
        
        alert.dismiss(animated: true, completion: nil)
    }
    
    func neutralButtonCallback(alert: UIAlertController, dateNow: Date = Date()) {
        userDefaults.set(dateNow, forKey: LogKey.buttonPressedTimestamp.rawValue)
        userDefaults.set(LogButtonType.neutral.rawValue, forKey: LogKey.buttonType.rawValue)
        
        if let delegate, let neutralButtonPressed = delegate.neutralButtonPressed {
            neutralButtonPressed()
        }
        
        alert.dismiss(animated: true, completion: nil)
    }
    
    func negativeButtonCallback(alert: UIAlertController, dateNow: Date = Date()) {
        self.userDefaults.set(dateNow, forKey: LogKey.buttonPressedTimestamp.rawValue)
        self.userDefaults.set(LogButtonType.negative.rawValue, forKey: LogKey.buttonType.rawValue)
        
        if let delegate, let negativeButtonPressed = delegate.negativeButtonPressed {
            negativeButtonPressed()
        }
        
        alert.dismiss(animated: true, completion: nil)
    }
    
    func openLink() throws {
        guard let url = URL(string: link) else { throw OpenLinkError.cantConvertLinkToUrl }
        guard let presenter else { throw OpenLinkError.presenterNotSet }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariViewController = SFSafariViewController(url: url, configuration: config)
        
        presenter.present(safariViewController, animated: true)
    }
}
