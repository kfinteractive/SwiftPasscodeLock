//
//  EnterPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public let PasscodeLockIncorrectPasscodeNotification = "passcode.lock.incorrect.passcode.notification"

struct EnterPasscodeState: PasscodeLockStateType {
    
    let title: String
    let description: String
    let isCancellableAction: Bool
    var isTouchIDAllowed = true
    
    static let incorrectPasscodeAttemptsKey = "incorrectPasscodeAttempts"
    static var incorrectPasscodeAttempts: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(incorrectPasscodeAttemptsKey)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: incorrectPasscodeAttemptsKey)
        }
    }
    
    init(allowCancellation: Bool = false) {
        
        isCancellableAction = allowCancellation
        title = localizedStringFor("PasscodeLockEnterTitle", comment: "Enter passcode title")
        description = localizedStringFor("PasscodeLockEnterDescription", comment: "Enter passcode description")
    }
    
    mutating func acceptPasscode(passcode: [String], fromLock lock: PasscodeLockType) {
        
        guard let currentPasscode = lock.repository.passcode else {
            return
        }
        
        var incorrectPasscodeAttempts = EnterPasscodeState.incorrectPasscodeAttempts
        if passcode == currentPasscode {
            
            lock.delegate?.passcodeLockDidSucceed(lock)
            incorrectPasscodeAttempts = 0
        } else {
            
            incorrectPasscodeAttempts += 1
            
            if incorrectPasscodeAttempts >= lock.configuration.maximumInccorectPasscodeAttempts {
                
                postNotification()
                incorrectPasscodeAttempts = 0
            }
            
            lock.delegate?.passcodeLockDidFail(lock)
        }
        
        EnterPasscodeState.incorrectPasscodeAttempts = incorrectPasscodeAttempts
    }
    
    private mutating func postNotification() {
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.postNotificationName(PasscodeLockIncorrectPasscodeNotification, object: nil)
    }
}