//
//  PasscodeLockConfigurationType.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public protocol PasscodeLockConfigurationType {
    
    var repository: PasscodeRepositoryType {get}
    var passcodeLength: Int {get}
    var isBiometricAuthenticationAllowed: Bool {get set}
    var shouldRequestTouchIDImmediately: Bool {get}
    var touchIdReason: String? {get set}
    var maximumInccorectPasscodeAttempts: Int {get}
    var touchIDAuthenticationAllowableReuseDuration: TimeInterval {get}
}
